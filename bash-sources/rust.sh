#!/bin/bash

function install_rust {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
}
sd::lazy_install_hook cargo install_rust

if [ -d $(readlink -f ~/.cargo) ] ; then
    source $HOME/.cargo/env
    sd::path::prepend "${HOME}/.cargo/bin"
fi
