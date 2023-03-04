#!/bin/bash


sd::path::prepend "/opt/nodejs/latest/bin"

# we need to load nvm if it already exists before we define the lazy install fns!
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ] ; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

function install_node {
    nvm install stable
}
sd::lazy_install_hook node install_node

function install_nvm {
    url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh"
    curl -o- "$url" | bash
    sed -ri '/NVM_DIR/d' ~/.bashrc
}
sd::lazy_install_hook nvm install_nvm
