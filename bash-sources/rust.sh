#!/bin/bash

function install_rust {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    sed -ri '^.cargo/env^d' ~/.bashrc
}
sd::lazy_install_hook cargo install_rust

if [ -d $(readlink -f ~/.cargo) ] ; then
    sd::path::prepend "${HOME}/.cargo/bin"
fi
