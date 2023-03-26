
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    # /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

function init_ssh_agent {
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        #ps ${SSH_AGENT_PID} doesn't work under cywgin
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
    else
        start_agent;
    fi
}
sd::func::jit "ssh scp git" init_ssh_agent


# Run a local ssh server in a docker container
function ssh_local_start {
    tmpdir=$(mktemp -d)
    cat <<-EOF > "${tmpdir}/Dockerfile"
FROM ubuntu
RUN apt-get update && apt-get install -y openssh-server
RUN useradd -m -d /host_home -s /bin/bash user
RUN mkdir -p /run/sshd
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
EOF
    docker build -t g-local-ssh "${tmpdir}"
    rm -rf "${tmpdir}"

    docker run \
        -d \
        --rm \
        -p 0.0.0.0:22:22 \
        -v "${HOME}":/host_home \
        --name g-local-ssh \
        g-local-ssh

    echo "stop the local ssh server with 'ssh_local_stop'"
}

function ssh_local_stop {
    docker kill g-local-ssh
}
