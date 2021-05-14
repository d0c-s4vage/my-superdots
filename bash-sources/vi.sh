#set -o vi
export EDITOR=vim

function vim-fast {
    vim --noplugin -u /dev/null "$@"
}

function vim-ansi {
    if [ $# -ne 1 ] ; then
        echo "USAGE: vim-ansi FILENAME"
        return 1
    fi
    vim -c ":term cat $1"
}
