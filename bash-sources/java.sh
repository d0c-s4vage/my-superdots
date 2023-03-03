#!/usr/bin/env bash


THIS_PROG="$0"


function install_javac {
    echo test
}
sd::lazy_install_hook javac install_javac


function install_sdkman {
    if [ -e "$HOME/.sdkman" ] ; then
        echo $SHLVL
        sd::log::info initing sdkman
        init_sdkman
        export -f sdk
        return 0
    fi

    sd::log::command bash -c "curl -s 'https://get.sdkman.io' | bash"
    sed -ri '/(sdkman|SDKMAN)/d' ~/.bashrc

    init_sdkman
    export -f sdk
}
SD_HOOK_TYPE=function sd::lazy_install_hook sdk install_sdkman

function init_sdkman {
    export SDKMAN_DIR="$HOME/.sdkman"
    . "$SDKMAN_DIR/bin/sdkman-init.sh"
}
