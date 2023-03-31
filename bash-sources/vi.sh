#set -o vi
export EDITOR=vim

function vim-fast {
    vim --noplugin -u /dev/null "$@"
}

function vim-ansi {
    if [ $# -ne 1 ] ; then
        echo "USAGE: vim-ansi FILENAME"
        return 1
    fi
    vim -c ":term cat $1"
}

function install_neovim {
    sudo apt install -yq neovim
    
    echo "source ~/.vimrc" >> ~/.config/nvim/init.vim

    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
sd::lazy_install_hook --interactive vim install_neovim
