#!/usr/bin/env bash

function install_ruby {
    log "Installing ruby 3.2.1 with rbenv"
    rbenv install 3.2.1
    rbenv global 3.2.1
}
lazy_install_hook ruby install_ruby
lazy_install_hook irb install_ruby


function install_rbenv {
    log "installing rbenv dependencies"
    log_command sudo apt-get install \
        autoconf \
        bison \
        patch \
        build-essential \
        rustc \
        libssl-dev \
        libyaml-dev \
        libreadline6-dev \
        zlib1g-dev \
        libgmp-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm6 \
        libgdbm-dev \
        libdb-dev \
        uuid-dev

    log "rbenv not found on path, installing it"
    url="https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer"
    curl -fsSL "$url" | bash
    do_rbenv_init
}
lazy_install_hook rbenv install_rbenv

function do_rbenv_init {
    local rbenv_init_commands=$(rbenv init - | grep -v "export PATH")
    eval "$rbenv_init_commands"

    path_prepend "${HOME}/.rbenv/bin"
    path_prepend "${HOME}/.rbenv/shims"
}

bin_exists rbenv && do_rbenv_init
