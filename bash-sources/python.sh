function install_pyenv {
    sd::log::command bash -c "curl https://pyenv.run | bash"
    init_pyenv
}
sd::lazy_install_hook pyenv install_pyenv

function init_pyenv {
    export PYENV_ROOT="$HOME/.pyenv"
    sd::path::prepend "$PYENV_ROOT/bin"
    eval "$(pyenv init -)"
}

#if [ -e "$HOME/.pyenv/bin/pyenv" ] ; then
#    init_pyenv
#fi

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
