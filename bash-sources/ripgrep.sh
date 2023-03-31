#!/usr/bin/env bash

function install_rg {
    sudo apt install -yq ripgrep
}

sd::lazy_install_hook --interactive rg install_rg
