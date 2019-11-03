#!/usr/bin/env bash

PATH="$PATH:$HOME/.rbenv/bin"

if ! hash rbenv ; then
    echo "rbenv not found, installing"
    url="https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer"
    curl -fsSL "$url" | bash
    rbenv init
    #rbenv install 2.6.3
    #rbenv global 2.6.3
fi

eval "$(rbenv init -)"
