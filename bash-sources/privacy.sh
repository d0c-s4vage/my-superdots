#!/usr/bin/env bash

PROXY_HOST=${PROXY_HOST:-""}
PROXY_SSH_KEY=${PROXY_SSH_KEY:-""}
PROXY_BIND_IP=${PROXY_BIND_IP:-""}
PROXY_PORT_SOCKS=${PROXY_PORT_SOCKS:-7070}
PROXY_PORT_HTTP=${PROXY_PORT_HTTP:-8888}
PROXY_PORT_HTTP_REMOTE=${PROXY_PORT_HTTP_REMOTE:-8888}
PROXY_BROWSER=${PROXY_BROWSER:-"chromium-browser"}

function ssh_setup {
    ssh-add -l | grep -q $(realpath "$PROXY_SSH_KEY") || ssh-add "$PROXY_SSH_KEY"

    ssh_opts=""

    bind_opt=""
    if [ ! -z "$PROXY_BIND_IP" ] ; then
        bind_opt="$PROXY_BIND_IP:"
    fi

    ssh \
        -D "$bind_opt""$PROXY_PORT_SOCKS" \
        -L "$bind_opt""$PROXY_PORT_HTTP:localhost:$PROXY_PORT_HTTP_REMOTE" \
        -N \
        "$PROXY_HOST" \
        >ssh_tunnel.log 2>&1 &

    sshpid=$!
}

function ssh_teardown {
    kill $sshpid
}

function error_check {
    error=false
    if [ -z "$PROXY_HOST" ] ; then
        echo "PROXY_HOST must be set"
        error=true
    fi
    if [ -z "$PROXY_SSH_KEY" ] ; then
        echo "PROXY_SSH_KEY must be set"
        error=true
    fi
    if [ -z "$PROXY_PORT" ] ; then
        echo "PROXY_PORT must be set"
        error=true
    fi
}

function pcurl {
    error_check
    if [ "$error" = true ] ; then
        return
    fi

    curl --proxy "socks5://127.0.0.1:$PROXY_PORT" "$@"
}


function browse_vm {
    ssh_setup
}


function browse {
    setup_urls=(
        https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
        #https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp
        https://chrome.google.com/webstore/detail/user-agent-switcher-for-c/djflhoibgkdhkhhcedjiklpkjnoahfmg
        https://chrome.google.com/webstore/detail/duckduckgo-privacy-essent/bkdgflcldnnnapblkhphbgpggdiikppg
    )

    error_check
    if [ "$error" = true ] ; then
        return
    fi

    ssh_setup

    proxy_dir=$(mktemp -d)
    if [ -d "$proxy_dir" ] ; then
        rm -rf "$proxy_dir"
    fi
    CMD=(
        $PROXY_BROWSER
            --no-first-run
            --no-default-browser-check
            --user-data-dir="$proxy_dir"
            --proxy-server=socks5://127.0.0.1:"$PROXY_PORT"
            --disable-gpu
            --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE 127.0.0.1"
            "${setup_urls[@]}"
            $@
    )
    "${CMD[@]}"

    rm -rf "$proxy_dir"

    ssh_teardown
}
