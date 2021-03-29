#!/usr/bin/env bash

function last_screenshot() {
    ls -t ~/Pictures/Screenshot*.png | head -n 1 | tr -d '\n' | copy
}
