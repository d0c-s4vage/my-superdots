#!/usr/bin/env bash

function install_rg {
    sudo apt install ripgrep
}

sd::lazy_install_hook rg install_rg
