#!/usr/bin/env bash


function file_is_zeroes {
    if [ $# -ne 1 ] ; then
        echo "USAGE: file_is_zeroes FILENAME"
        echo
        echo "    true/false based on the exit code"
        return 1
    fi

    file="$1"
    <"${file}" tr -d '\0' | read -n 1

    if [ $? -ne 0 ] ; then
        return 0
    else
        return 1
    fi
}
