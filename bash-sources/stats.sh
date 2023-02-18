#!/usr/bin/env bash


# depends on chart-bar
function histogram-search {
    if [ $# -lt 1 ] ; then
        echo "USAGE: histogram-search TERM1 TERM2 TERM3"
        echo ""
        echo "use MAX_CHARS=N histogram-search .... to control the width of the char"
        return 1
    fi

    search_path="" # leave it empty
    if [ ! -t 0 ] ; then
        tmpfile=$(mktemp /tmp/histogram_tmp.XXXXXX)
        cat > "$tmpfile"
        search_path="$tmpfile"
    fi

    chart-bar $(
        for term in "$@" ; do
            safe_term=$(sed 's/ /-/g' <<<"$term")
            echo "$term:$(rg -o "$term" $search_path | wc -l)"
        done | xargs
    )

    if [ ! -z "$tmpfile" ] ; then
        rm "$tmpfile"
    fi
}
