#!/usr/bin/env bash

LOG_PREFIX="[>>>]"

function log {
    echo "${LOG_PREFIX} $@"
}

function log_command {
    log "Running command:"
    log "  $@"
    "$@" 2>&1 | log_box_indent
}

function log_indent {
    sed "s/^/    /g"
}

function log_box_indent {
    log '  ╭──────'
    sed "s/^/${LOG_PREFIX}   │ /g"
    log '  ╰──────'
}

function indent {
    sed "s/^/    /g"
}

function box_indent {
    echo '  ╭──────'
    sed "s/^/  │ /g"
    echo '  ╰──────'
}
