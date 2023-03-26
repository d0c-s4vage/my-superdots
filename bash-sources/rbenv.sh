#!/usr/bin/env bash

THIS_PROG="$BASH_SOURCE"

function _ruby_irb_init {
    if ! sd::bin_exists ruby ; then
        rbenv install 3.2.1
        rbenv global 3.2.1
    fi
    sd::log::debug should be inited
}

function check_rbenv {
    [ -f ~/.rbenv/bin/rbenv ]
}

function install_rbenv {
    git clone --depth 1 https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone --depth 1 https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
}

function init_rbenv {
    to_eval=$(~/.rbenv/bin/rbenv init - bash | grep -v PATH)
    sd::path::prepend "${HOME}/.rbenv/bin"
    sd::path::prepend "${HOME}/.rbenv/shims"

    eval "$to_eval"
}


sd::func::lazy_create --func rbenv --install install_rbenv --check check_rbenv --init init_rbenv
sd::func::jit ruby _ruby_irb_init
sd::func::jit irb _ruby_irb_init
