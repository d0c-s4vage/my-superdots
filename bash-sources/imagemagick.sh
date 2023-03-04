#!/usr/bin/env bash


THIS_PROG="$BASH_SOURCE"


function install_imagemagick {
    sudo apt install -yq imagemagick
}

sd::lazy_install_hook --needs-sudo convert install_imagemagick
