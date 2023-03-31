#!/usr/bin/env bash


THIS_PROG="$0"

function gum_log_command {
    sd::log::_msg "Running command:"
    
    local title=$(sd::log::_inline "  │ ")

    local first_arg="$1"
    shift
    sd::func::escaped_args --out output -- "$@"
    local cmd_to_run="$first_arg $output"

    sd::log::_msg "  $cmd_to_run"

    sd::func::escaped_args --out escaped_title -- "$title"
    eval "gum spin --title $escaped_title --align right --show-output -- bash -c \"($cmd_to_run) 2>&1\" | sd::log::_box_indent"
}

if sd::bin_exists gum ; then
    alias sd::log::_command=gum_log_command
fi
