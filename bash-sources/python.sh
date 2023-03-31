function install_pyenv {
    curl https://pyenv.run | bash
    init_pyenv

    sudo apt install -yq libbz2-dev liblzma-dev tk-dev

    pyenv install 3.11.2
}

if [ -e "$HOME/.pyenv/bin/pyenv" ] ; then
    sd::func::jit pyenv init_pyenv
else
    sd::lazy_install_hook --interactive pyenv install_pyenv
fi

sd::func::jit "python3 python" init_pyenv

function init_pyenv {
    export PYENV_ROOT="$HOME/.pyenv"
    sd::path::prepend "$PYENV_ROOT/bin"
    eval "$(pyenv init -)"
}


function venv2 {
	dest="./venv2"
	if [ $# -eq 1 ] ; then
		dest="$1"
	fi

	if [[ ! -d "$dest" ]] ; then
		echo "creating virtual environment with python2 at $dest"
        virtualenv --python $(which python2) "$dest"
	fi

	source "$dest/bin/activate"
}

function venv3 {
	dest="./venv3"
	if [ $# -eq 1 ] ; then
		dest="$1"
	fi

	if [[ ! -d "$dest" ]] ; then
		echo "creating virtual environment with python3 at $dest"
        virtualenv --python $(which python3) "$dest"
	fi

	source "$dest/bin/activate"
}
