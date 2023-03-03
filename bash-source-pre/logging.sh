#!/usr/bin/env bash


THIS_PROG="$0"

function gum_log_command {
    sd::log::_msg "Running command:"
    
    local title=$(sd::log::_inline "  │ ")
    sd::func::escaped_args --out output -- "$@"
    sd::log::_msg "  $output"

    sd::func::escaped_args --out escaped_title -- "$title"
    eval "gum spin --title $escaped_title --align right --show-output -- bash -c \"$output\" | sd::log::_box_indent"
}

if sd::bin_exists gum ; then
    alias sd::log::_command=gum_log_command
fi
