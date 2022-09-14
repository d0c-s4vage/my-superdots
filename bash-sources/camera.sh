#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"


function webcam_init {
    uvcdynctrl --device=video2 --set="Zoom, Absolute" 125 || echo "Zoom"
	uvcdynctrl --device=video2 --set="Tilt (Absolute)" -- -10000 || echo "Tilt"
}