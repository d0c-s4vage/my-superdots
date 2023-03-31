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

function bench_it {
    local iters=""
    local loud=false
    local usage=$(cat <<-EOF
USAGE: $0 --iters NUM_ITERS [--loud] -- CMD_ARGS...

   --iters,-i ITERS   Number of iterations
    --loud,-l         No output suppression
    --help,-h

EOF
)

    while [ $# -ne 0 ] ; do
        local arg="$1"
        case "$arg" in
            --help|-h)
                echo "$usage"
                return 1
                ;;
            --loud|-l)
                loud=true
                ;;
            --iters|-i)
                shift
                iters="$1"
                ;;
            --)
                shift
                break
                ;;
            *)
                sd::log::error "Unknown argument: ${arg@Q}"
                sd::log::note
                sd::log::note "$usage"
                return 1
                ;;
        esac

        shift
    done

    if ! [[ "$iters" =~ ^[0-9]+$ ]] || [ -z "$iters" ]; then
        sd::log::error "NUM_ITERS must be a numeric integer, got ${iters@Q}"
        sd::log::note
        sd::log::note "$usage"
        return 1
    fi

    if [ -z "$*" ] ; then
        sd::log::error "CMD_ARGS must be provided"
        sd::log::note
        sd::log::note "$usage"
        return 1
    fi
    
    local orig_iters="$iters"

    start=$(python3 -c "import time ; print(time.time())")
    while [ "$iters" -gt 0 ] ; do
        ((iters--))
        if [ "$loud" = true ] ; then
            "$@"
        else
            "$@" >/dev/null 2>&1
        fi
    done

    cat <<-EOF | python3
import time

start = $start
now = time.time()
elapsed = now - start

seconds_per_iter = elapsed / ${orig_iters}.0
iters_per_second = ${orig_iters}.0 / elapsed

print("{:15.05f} s/iter".format(seconds_per_iter))
print("{:15.05f} iter/s".format(iters_per_second))
EOF
}
