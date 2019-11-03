DOCKER_REQUIRES_SUDO=${DOCKER_REQUIRES_SUDO:=true}

if [ "$DOCKER_REQUIRES_SUDO" = true ] ; then
    DOCKER="sudo docker"
else
    DOCKER="docker"
fi

function ddrop {
    docker run --rm -it -v $(pwd):/pwd --workdir /pwd --entrypoint bash "$1"
}

function docker_netstat {
    image_name="$1"
    shift
    pid=$($DOCKER inspect -f '{{.State.Pid}}' "$image_name")
    sudo nsenter -t "$pid" -n netstat "$@"
}

function docker_cmd {
    image_name="$1"
    shift
    pid=$($DOCKER inspect -f '{{.State.Pid}}' "$image_name")
    sudo nsenter -t "$pid" -n "$@"
}

function docker_ip {
    $DOCKER inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1
}
