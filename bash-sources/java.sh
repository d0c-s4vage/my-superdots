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
        return 0
    fi

    sd::log::command bash -c "curl -s 'https://get.sdkman.io' | bash"
    sed -ri '/(sdkman|SDKMAN)/d' ~/.bashrc

    init_sdkman
}

function check_sdkman {
    [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]
}

function init_sdkman {
    export SDKMAN_DIR="$HOME/.sdkman"
    . "$SDKMAN_DIR/bin/sdkman-init.sh"
    export -f sdk
}

sd::func::lazy_create --func sdk --check check_sdkman --install install_sdkman --init init_sdkman
