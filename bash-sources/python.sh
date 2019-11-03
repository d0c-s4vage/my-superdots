# virtualenvwrapper
#export WORKON_HOME=~/.venvs
#wrapper=/usr/local/bin/virtualenvwrapper.sh
#if [ -e "$wrapper" ] ; then
#    . "$wrapper"
#else
#    echo "Virtualenvwrapper script does not exist at '$wrapper'"
#    echo "Make sure you have installed virtualenvwrapper globally with"
#    echo ""
#    echo "    sudo pip install virtualenvwrapper"
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
