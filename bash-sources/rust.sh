#!/bin/bash

function install_rust {
    echo ""
    echo "---------------------------------"
    echo "Rust is not installed, installing"
    echo "---------------------------------"
    echo ""
    curl https://sh.rustup.rs -sSf | sh 
}

if [ -d $(readlink -f ~/.cargo) ] ; then
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH"
fi
