#!/usr/bin/env bash

function install_gum {
    sd::log::command sudo mkdir -p /etc/apt/keyrings
    sd::log::command bash -c "curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/charm.gpg"
    sd::log::command bash -c 'echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list'
    sd::log::command bash -c "sudo apt update && sudo apt install gum"

    reload
}
sd::lazy_install_hook gum install_gum

function sd::ux::gum_confirm {
    if ! sd::bin_exists gum ; then
        sd::log::debug setting ux::confirm to orig_confirm
        alias sd::ux::confirm=sd::ux::orig_confirm
    fi

    gum confirm "$@"
    res=$?

    if sd::bin_exists gum ; then
        alias sd::ux::confirm=sd::ux::gum_confirm
        return $res
    else
        sd::log::debug "Still not using gum, falling back to orig_confirm"
        # and finally we still need to call orig_confirm if gum wasn't installed
        sd::ux::orig_confirm "$@"
        return $?
    fi
}

alias sd::ux::confirm=sd::ux::gum_confirm
