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
