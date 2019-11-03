# my-superdots

This project is a [superdots](https://github.com/super-dots/superdots) plugin.

- [Description](#description)
- [Installing](#installing)
- [Updating](#updating)
- [Features](#features)
  * [Bash Functions](#bash-functions)
  * [Tmux](#tmux)
  * [Vim](#vim)

## Description

d0c-s4vage's superdots

## Installing

After installing superdots, record this as a plugin in your ~/.bashrc:

```
source /path/to/superdots/bash_init.sh  # should already be there from installing

superdots d0c-s4vage/my-superdots
```

And then run the command below to install the plugin

```
superdots-install
```

## Updating

To update your local copy of this plugin to the latest version, run the command
below:

```
superdots-upgrade
```

## Features

### Bash Functions

This superdots plugin comes with over 50 categorized bash functions:

```
bash-sources                                                                                                                                                                          
├── aliases.sh                                                                                                                                                                        
├── asm.sh                                                                                                                                                                            
├── completion.sh                                                                                                                                                                     
├── compression.sh                                                                                                                                                                    
├── copy.sh                                                                                                                                                                           
├── cscope.sh                                                                                                                                                                         
├── docker.sh                                                                                                                                                                         
├── files.sh
├── git.sh
├── hackers.sh
├── json.sh
├── k8s.sh
├── main.sh
├── misc.sh
├── nodejs.sh
├── overlay.sh
├── path.sh
├── privacy.sh
├── prompt.sh
├── python.sh
├── qrcode.sh
├── random.sh
├── rbenv.sh
├── redshift.sh
├── rust.sh
├── screen.sh
├── serve.sh
├── ssh.sh
├── tmux.sh
└── vi.sh
```

### Tmux

This superdots plugin includes custom statusline settings to show:

* tmux session name
* current folder name
* tabs
* date / time
* battery life
* current branch name

### Vim

Uses [vim-plug](https://github.com/junegunn/vim-plug) for vim plugin management,
including UltiSnips, language server, and more.

See [`vim-sources/aaa_plugins.vim`](./vim-sources/aaa_plugins.vim) for all
defined/categorized settings and customizations.

Plugins as of 2019-08-25 installed automatically with vim-plug:

* [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter)
* [autozimu/LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
* [d0c-s4vage/vim-morph](https://github.com/d0c-s4vage/vim-morph)
* [dhruvasagar/vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)
* [ervandew/supertab](https://github.com/ervandew/supertab)
* [fatih/vim-go](https://github.com/fatih/vim-go)
* [godlygeek/tabular](https://github.com/godlygeek/tabular)
* [honza/vim-snippets](https://github.com/honza/vim-snippets)
* [junegunn/fzf](https://github.com/junegunn/fzf)
* [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
* [Lokaltog/vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
* [nanotech/jellybeans.vim](https://github.com/nanotech/jellybeans.vim)
* [nvie/vim-flake8](https://github.com/nvie/vim-flake8)
* [rhysd/vim-grammarous](https://github.com/rhysd/vim-grammarous)
* [roxma/nvim-yarp](https://github.com/roxma/nvim-yarp)
* [roxma/vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc)
* [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)
* [Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* [Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* [SirVer/ultisnips](https://github.com/SirVer/ultisnips)
* [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
* [tpope/vim-markdown](https://github.com/tpope/vim-markdown)
* [tpope/vim-rails](https://github.com/tpope/vim-rails)
* [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
* [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
* [vim-ruby/vim-ruby](https://github.com/vim-ruby/vim-ruby)
* [vim-scripts/AfterColors.vim](https://github.com/vim-scripts/AfterColors.vim)
* [vim-scripts/SyntaxRange](https://github.com/vim-scripts/SyntaxRange)
* [vim-syntastic/syntastic](https://github.com/vim-syntastic/syntastic)
