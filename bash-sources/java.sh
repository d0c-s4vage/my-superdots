#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"


function _sdkman_init {
    export SDKMAN_DIR="$HOME/.sdkman"
    if [ ! -d ~/.sdkman ] ; then
        log "SDKMan hasn't been installed, yet, installing..."
        log 'curl -s "https://get.sdkman.io" | bash'
        curl -s "https://get.sdkman.io" | bash | log_box_indent
    fi
    . "$SDKMAN_DIR/bin/sdkman-init.sh"
}

# Uncomment this to have java
_sdkman_init
