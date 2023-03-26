#!/bin/bash


sd::path::prepend "/opt/nodejs/latest/bin"

# we need to load nvm if it already exists before we define the lazy install fns!
export NVM_DIR="$HOME/.nvm"

function check_nvm {
    [ -e "$NVM_DIR/nvm.sh" ]
}

function init_nvm {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function _install_node {
    nvm install stable
}

function init_node {
    init_nvm
    if ! sd::bin_exists node ; then
        sd::lazy_install_hook node _install_node
        NO_RUN=true node
    fi
}
sd::func::jit "vim nvim node" init_node

function install_nvm {
    url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh"
    curl -o- "$url" | bash
    sed -ri '/NVM_DIR/d' ~/.bashrc
}
sd::func::lazy_create --func nvm --check check_nvm --install install_nvm --init init_nvm
