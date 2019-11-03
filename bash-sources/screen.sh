
function ths {
	screen -X eval "chdir $PWD"
}

function dev {
    function newTab {
        title=""
        number=""
        existing=false
        cmd=""
        while [[ $# -gt 0 ]] ; do
            key="$1"
            case $key in
                # if the existing screen tab should be used
                --existing|-e)
                    existing=true
                    # no shifting for flags
                ;;
                # what number/position to set for the tab
                --number|--num|-n)
                    number="$2"
                    shift
                ;;
                # what the tab's title should be
                --title|-t)
                    title="$2"
                    shift
                ;;
                --cmd|-c)
                    cmd="$2"
                    shift
                ;;
            esac

            shift
        done

        if [ ! $existing = true ] ; then
            echo "screen" >> $screenFile
        fi

        if [ ! -z "$title" ] ; then
            echo "title $title" >> $screenFile
        fi

        if [ ! -z "$number" ] ; then
            echo "number $number" >> $screenFile
        fi

        if [ ! -z "$cmd" ] ; then
            echo -e "\nstuff \"$cmd\"" >> $screenFile
        fi
    }

    # make a new screen session named
    sessionName="$(basename $(pwd)) $(readlink -f $(pwd))"
    sessionName=$(echo $sessionName | sed 's/ /__/g' | sed 's^/^=^g')
    screen -ls | grep "$sessionName"
    if [ $? -eq 0 ] ; then
        screen -x "$sessionName"
        return
    fi

    screenFile=$(mktemp)
    cp ~/.screenrc "$screenFile"

    firstSrc=$(bfs -type d -iname src -or -iname $(basename $(pwd)) 2>/dev/null | head -n 1)
    if [ ! -z "$firstSrc" ] ; then
        newTab -t "src" -c "cd $(readlink -f $firstSrc) ; vim"
    else
        firstInit=$(bfs -maxdepth 6 -iname __init__.py 2>/dev/null | head -n 1)
        firstInit=$(readlink -f $firstInit)
        if [ ! -z "$firstInit" ] ; then
            newTab -t "src" -c "cd $(dirname $firstInit) ; vim"
        fi
    fi

    tests_dir=$(bfs -maxdepth 6 -iname tests 2>/dev/null | head -n 1)
    if [ ! -z "$tests_dir" ] ; then
        newTab -t "tests" -c "cd $tests_dir"
    fi

    if [ -d "./docs/source" ] ; then
        newTab -t "docs" -c "cd ./docs/source"
    fi
    newTab -t "debug2" -n 49

    reqFile=$(mktemp)
    echo "# AUTOGEND FOR $(basename $(pwd))" > "$reqFile"
    for req in $(find . -iname requirements.txt 2>/dev/null); do
        echo "-r $(readlink -f $req)" >> "$reqFile"
    done
    echo $reqFile
    newTab -t "debug" -n 50 -c "mkvirtualenv $(basename $(pwd)) -r $reqFile"

    screen -S "$sessionName" -c "$screenFile" -p "src"
}
