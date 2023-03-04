#!/usr/bin/env bash


THIS_PROG="$BASH_SOURCE"


function install_ffmpeg {
    sudo apt install -yq ffmpeg
}

sd::lazy_install_hook --needs-sudo ffmpeg install_ffmpeg
