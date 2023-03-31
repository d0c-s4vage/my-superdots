#!/usr/bin/env bash

function install_gum {
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install -yq gum

    reload
}
sd::lazy_install_hook --interactive gum install_gum

function sd::ux::gum_confirm {
    if ! sd::bin_exists gum ; then
        sd::log::debug setting ux::confirm to orig_confirm
        unalias sd::ux::confirm || true
    fi

    gum confirm "$@"
    res=$?

    if sd::bin_exists gum ; then
        alias sd::ux::confirm=sd::ux::gum_confirm
        return $res
    else
        sd::log::debug "Still not using gum, falling back to orig_confirm"
        sd::ux::confirm "$@"
        return $?
    fi
}

alias sd::ux::confirm=sd::ux::gum_confirm
