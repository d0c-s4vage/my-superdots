#!/usr/bin/env bash


THIS_PROG="$0"


function install_javac {
    echo test
}
sd::lazy_install_hook javac install_javac


function install_sdkman {
    log_command bash -c "curl -s 'https://get.sdkman.io' | bash"
    init_sdkman
}
sd::lazy_install_hook sdk install_sdkman

function init_sdkman {
    export SDKMAN_DIR="$HOME/.sdkman"
    . "$SDKMAN_DIR/bin/sdkman-init.sh"
}

if [ -e "$HOME/.sdkman" ] ; then
    init_sdkman
fi
