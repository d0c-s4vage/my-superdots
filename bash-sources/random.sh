#!/usr/bin/env bash

function rand_str {
    if [ $# -ne 1 ] ; then
        echo "USAGE: rand_str LENGTH"
        return 1
    fi
    
    head /dev/urandom | tr -dc 'A-Za-z0-9' | head -c $1
}
