#!/usr/bin/env bash


THIS_PROG="$0"

function _chart-bar-single {
    max_blocks="$1"
    max_value="$2"
    curr_value="$3"
    block_char=${4:-"█"}

    #num_blocks=$(echo "($curr_value * $max_blocks / $max_value) * $max_blocks" | bc)
    ((num_blocks=($curr_value * max_blocks) / $max_value))

    while [ $num_blocks -gt 0 ] ; do
        echo -en "$block_char"
        num_blocks=$((num_blocks - 1))
    done
}

function chart-bar {
    if [ $# -lt 1 ] ; then
        echo "USAGE: chart-bar [label:]NUM1 [label:]NUM2 [label:]NUM3"
        echo
        echo "Display a barchart of information. Use MAX_CHARS=N chart-bar ..."
        echo "To control the width of the bar chart"
        return 1
    fi

    labels=()
    numbers=()
    max_label_length=0
    # for now, only deal with positive numbers
    max_number_value=0
    for item in "$@" ; do
        if [[ "$item" == *':'?* ]] ; then
            label=$(sed 's/:.*//' <<<"$item")
            number=$(sed 's/.*://' <<<"$item")
        else
            label="-"
            number="$item"
        fi
        labels+=("$label")
        numbers+=("$number")

        curr_label_length="${#label}"
        if [ "$curr_label_length" -gt "$max_label_length" ] ; then
            max_label_length=$curr_label_length
        fi

        if [ "$number" -gt "$max_number_value" ] ; then
            max_number_value=$number
        fi
    done

    num_chars=${MAX_CHARS:-80}

    block_chars=("█" "▓" "▒" "░")
    block_char_idx=0

    for idx in "${!labels[@]}" ; do
        block_char="${block_chars[$block_char_idx]}"
        ((block_char_idx=($block_char_idx + 1) % ${#block_chars[@]}))

        single_bar=$(_chart-bar-single $num_chars $max_number_value ${numbers[$idx]} "$block_char")
        printf "%"$max_label_length"s ┃ %s (%d)\n" ${labels[$idx]} "$single_bar" ${numbers[$idx]}
    done
}

function chart-scatter {
    set -o functrace

    if [ $# -lt 1 ] ; then
        echo "USAGE: chart-scatter [label:] X,Y X,Y [label:] NUM2 [label:]NUM3 ..."
        echo ""
        echo "Display a scatterplot of information. Use MAX_HEIGHT=N  MAX_WIDTH=N chart-scatter ..."
        echo "To control the width of the bar chart"
        return 1
    fi
        
    labels=()
    marker_idx=0
    markers=("◊" "★" "✗" "♠" "● " "✓" "○" "◆" "◎" )
    if [ -z "$COLOR" ] ; then
        marker_colors=('' '' '' '' '')
    else
        marker_colors=('\e[31m' '\e[32m' '\e[33m' '\e[34m' '\e[35m')
    fi
    marker=${markers[0]}
    xes=()
    yes=()
    max_label_length=0
    # for now, only deal with positive numbers
    ((max_x_value=-(2**32)))
    ((min_x_value=2**32))
    ((max_y_value=-(2**32)))
    ((min_y_value=2**32))
    point_regex='^-?[0-9]+(\.[0-9]+)?,-?[0-9]+(\.[0-9]+)?'
    label=""
    for item in "$@" ; do
        if [[ "$item" =~ $point_regex ]] ; then
            x=$(sed 's/,.*//' <<<"$item")
            y=$(sed 's/.*,//' <<<"$item")
        else
            label=$(sed 's/:.*//' <<<"$item")
            marker="$marker_idx"
            ((marker_idx=($marker_idx + 1) % ${#markers[@]}))
            labels+=("$label")
            curr_label_length="${#label}"
            if [ "$curr_label_length" -gt "$max_label_length" ] ; then
                max_label_length=$curr_label_length
            fi
            continue
        fi

        # number first so that we can sort by numbers
        yes+=("$y:$marker:${#xes[@]}")
        xes+=("$x")

        if (( $(bc -l <<<"$x > $max_x_value") )) ; then
            max_x_value=$x
        fi
        if (( $(bc -l <<<"$x < $min_x_value") )) ; then
            min_x_value=$x
        fi

        if (( $(bc -l <<<"$y > $max_y_value") )) ; then
            max_y_value=$y
        fi
        if (( $(bc -l <<<"$y < $min_y_value") )) ; then
            min_y_value=$y
        fi
    done

    num_rows=${MAX_HEIGHT:-20}
    num_cols=${MAX_WIDTH:-50}
    row_increment=$(bc <<<"scale=5; ($max_y_value - $min_y_value) / $num_rows")
    col_increment=$(bc <<<"scale=5; ($max_x_value - $min_x_value) / $num_cols")

    # sort y values in decreasing order (we'll draw them from the top down)
    IFS=$'\n'
    yes=($(xargs -n1 <<<"${yes[@]}" | sort -nr -t: -k1))
    unset IFS

    # itereate all y values, prepend a row index so that we can group the values
    # by using the row_increment
    for idx in "${!yes[@]}" ; do
        y=$(sed 's/\(.*\):\(.*\):\(.*\)/\1/' <<<"${yes[$idx]}")
        label=$(sed 's/\(.*\):\(.*\):\(.*\)/\2/' <<<"${yes[$idx]}")
        xidx=$(sed 's/\(.*\):\(.*\):\(.*\)/\3/' <<<"${yes[$idx]}")

        # x_val:row:y_val:label -> col:row:x_val:y_val:label
        row=$(bc <<<"scale=0; ($max_y_value - $y) / $row_increment")
        # row goes from top-down (0 -> +)
        yes[$idx]="${xes[$xidx]}:$row:$y:$label"
    done

    # sort y values in INCREASING order now
    IFS=$'\n'
    yes=($(xargs -n1 <<<"${yes[@]}" | sort -n -t: -k1))
    unset IFS

    for idx in "${!yes[@]}" ; do
        re='\(.*\):\(.*\):\(.*\):\(.*\)'
        x=$(sed "s/$re/\1/" <<<"${yes[$idx]}")
        row=$(sed "s/$re/\2/" <<<"${yes[$idx]}")
        y=$(sed "s/$re/\3/" <<<"${yes[$idx]}")
        label=$(sed "s/$re/\4/" <<<"${yes[$idx]}")

        # x_val:row:y_val:label -> col:row:x_val:y_val:label
        col=$(bc <<<"scale=0; ($x - $min_x_value) / $col_increment")
        yes[$idx]="$row:$col:$x:$y:$label"
    done

    # final sorting!
    IFS=$'\n'
    yes=($(xargs -n1 <<<"${yes[@]}" | sort -n -t: -k1))
    unset IFS

    curr_row=-1
    curr_col=0
    last_drawn_marker_row=-1
    last_drawn_marker_col=-1
    ((max_col=-(2**32)))
    for idx in "${!yes[@]}" ; do
        re='\(.*\):\(.*\):\(.*\):\(.*\):\(.*\)'
        row=$(sed "s/$re/\1/" <<<"${yes[$idx]}")
        col=$(sed "s/$re/\2/" <<<"${yes[$idx]}")
        x=$(sed "s/$re/\3/" <<<"${yes[$idx]}")
        y=$(sed "s/$re/\4/" <<<"${yes[$idx]}")
        marker_idx=$(sed "s/$re/\5/" <<<"${yes[$idx]}")
        marker="${markers[$marker_idx]}"

        if [[ $col -gt $max_col ]] ; then
            max_col=$col
        fi

        while [[ $curr_row -lt $row ]] ; do
            echo ""
            ((curr_row=$curr_row + 1))
            #if (( $(bc -l <<<"$x > $max_x_value") )) ; then
            if (( $(bc <<<"($curr_row % 3) == 0") )) ; then
                printf "%10s ┤ " $(bc <<<"scale=1; ($max_y_value - ($curr_row * $row_increment)) / 1.0" )
            else
                printf "%10s ┤ " " "
            fi

            curr_col=0
        done

        while [[ $curr_col -lt $col ]] ; do
            echo -n " "
            ((curr_col=$curr_col + 1))
        done

        if [[ $last_drawn_marker_row -eq $row ]] && [[ $last_drawn_marker_col -eq $col ]] ; then
            continue
        fi
        echo -en "${marker_colors[$marker_idx]}${marker}\e[0m"
        last_drawn_marker_row=$row
        last_drawn_marker_col=$col
    done

    printf "\n%10s └─" " "
    curr_col=0
    tick_period=8
    ((max_col++))
    while [[ $curr_col -ne $max_col ]] ; do
        if (( $(bc <<<"($curr_col % $tick_period) == 0") )) ; then
            echo -n "┬"
        else
            echo -n "─"
        fi
        ((curr_col++))
    done

    curr_col=-1
    printf "\n%7s" " "
    curr_val=$min_x_value
    while [[ $curr_col -ne $max_col ]] ; do
        ((curr_col++))
        if (( $(bc <<<"($curr_col % 8) == 0") )) ; then
            printf "%${tick_period}s" $(bc <<<"scale=1; $curr_val / 1.0")
        fi
        curr_val=$(bc <<<"scale=5; $curr_val + $col_increment")
    done

    echo
    echo

    # print the legend
    for idx in "${!labels[@]}"; do
        label_marker="${markers[$idx]}"
        printf "%s - %-${max_label_length}s\n" $(echo -en "${marker_colors[$idx]}${label_marker}\e[0m") "${labels[$idx]}"
    done
}
