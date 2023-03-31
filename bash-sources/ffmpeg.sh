#!/usr/bin/env bash


THIS_PROG="$BASH_SOURCE"


function install_ffmpeg {
    sudo apt install -yq ffmpeg
}

sd::lazy_install_hook --interactive ffmpeg install_ffmpeg
