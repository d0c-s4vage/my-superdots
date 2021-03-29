
function fix_dummy_sound {
    pulseaudio -k && sudo alsa force-reload
}
