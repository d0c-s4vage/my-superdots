#!/bin/bash


sd::path::prepend "/opt/nodejs/latest/bin"

function install_node {
    nvm install stable
}
sd::lazy_install_hook node install_node

function install_nvm {
    url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh"
    curl -o- "$url" | bash
}
sd::lazy_install_hook nvm install_nvm

if sd::bin_exists node ; then
    # sometimes node will drop us into a REPL when we do node --version, not
    # sure why
    node --version >/dev/null </dev/null
fi
