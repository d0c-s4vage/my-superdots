DOCKER_REQUIRES_SUDO=${DOCKER_REQUIRES_SUDO:=true}

if [ "$DOCKER_REQUIRES_SUDO" = true ] ; then
    DOCKER="sudo docker"
else
    DOCKER="docker"
fi

function ddrop {
    $DOCKER run --rm -it -v $(pwd):/pwd --workdir /pwd --entrypoint bash "$1"
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

function install_docker {
    sd::log "Setting up docker apt repository"
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sd::log "Updating with new apt source"
    sd::log::command sudo apt update -yq

    sd::log "Installing docker and related libs/tools"
    sd::log::command sudo apt install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sd::log "Should you be added to the docker group? (y/n)"
    if [ "$answer" == "${answer#[Yy]}" ] ; then
        sd::log "Ok, not installing"
        return 1
    fi
}
sd::lazy_install_hook --interactive docker install_docker
