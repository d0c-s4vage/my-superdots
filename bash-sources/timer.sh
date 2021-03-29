function rand_say {
    rand_voice=$(espeak --voices | tail -n +2 | awk '{print $2}' | grep -E "^en" | shuf | head -n 1)
    espeak -v "$rand_voice" "$@"
}

function timer {
    if [ $# -ne 2 ] ; then
        echo "USAGE: timer DURATION NAME"
        return 1
    fi

    duration=$(($1 * 60))
    name="$2"
    chunk=$((5 * 60))

    while [ $duration -gt $chunk ] ; do
        rand_say "$(($duration / 60)) minutes left for $name"
        sleep $chunk
        duration=$(($duration - $chunk))
    done
    rand_say "$((duration / 60)) minutes left for $name"
    sleep $duration
    rand_say "All done with $name, move on with your day"
}
