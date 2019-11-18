#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"


function asciinema_to_gif {
    if [ $# -lt 2 ] ; then
        echo "USAGE: asciinema_to_gif INPUT_CAST OUTPUT_GIF [--extra-options...]"
        echo "Note, both input_cast and output_gif must be files in your CWD"
        return 1
    fi
    input_file="$1"
    output_file="$2"
    shift
    shift
    docker run \
        --rm -v "$PWD:/data" \
        asciinema/asciicast2gif -s 2 "$input_file" "$output_file" $@
}
