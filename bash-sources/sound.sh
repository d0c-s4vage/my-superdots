
function fix_dummy_sound {
    pulseaudio -k && sudo alsa force-reload
}

function fix_bluetooth {
    systemctl --user restart pulseaudio.service
}
