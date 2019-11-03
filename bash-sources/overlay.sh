

function overlay {
    if [ $# -ne 3 ] ; then
        echo "USAGE: $0 LOWER UPPER MERGED"
        return 1
    fi

    lower="$1"
    upper="$2"
    work=$(mktemp -d)
    merged="$3"

    abspath_merged=$(readlink -f "${merged}")

    if (mount | grep "${abspath_merged}") ; then
        sudo umount "${abspath_merged}"
    fi

    cmd=(
        sudo mount
            -t overlay
            --options lowerdir="${lower}",upperdir="${upper}",workdir="${work}"
            overlay
            "${merged}"
    )
    "${cmd[@]}"
}

function some_new_function {
    if [ $# -ne 1 ] ; then
        echo "USAGE: some_new_function BLAH"
        return 1
    fi
    echo $1
}
