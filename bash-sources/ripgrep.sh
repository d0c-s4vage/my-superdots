#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


function install_rg {
    sudo apt install ripgrep
}

sd::lazy_install_hook rg install_rg
