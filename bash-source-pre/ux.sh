#!/usr/bin/env bash

function install_gum {
    log_command sudo mkdir -p /etc/apt/keyrings
    log_command bash -c "curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/charm.gpg"
    log_command bash -c 'echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list'
    log_command bash -c "sudo apt update && sudo apt install gum"

    override_sd_confirm
}
sd::lazy_install_hook gum install_gum

function gum_confirm {
    gum confirm "$@"
}

function sd::ux::confirm {
    if ! bin_exists gum ; then
        sd::func::override sd::ux::confirm sd::ux::orig_confirm
    fi

    gum confirm "$@"

    if bin_exists gum ; then
        sd::func::override sd::ux::confirm gum_confirm
    fi
}
