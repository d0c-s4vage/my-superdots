#!/usr/bin/env bash


function webcam_init {
    uvcdynctrl --device=video2 --set="Zoom, Absolute" 125 || echo "Zoom"
	uvcdynctrl --device=video2 --set="Tilt (Absolute)" -- -10000 || echo "Tilt"
}
