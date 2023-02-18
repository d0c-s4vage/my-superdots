#!/bin/bash


path_prepend "/opt/nodejs/latest/bin"

function install_node {
    nvm install stable
}
lazy_install_hook node install_node

function install_nvm {
    url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh"
    curl -o- "$url" | bash
}
lazy_install_hook nvm install_nvm
