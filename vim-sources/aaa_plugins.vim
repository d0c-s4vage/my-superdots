set encoding=utf-8
let s:this_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" vim-plug
call plug#begin('~/.vim/plugged')


" -----------------------------------------------------------------------------
" Language Server Client ------------------------------------------------------
" -----------------------------------------------------------------------------

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'do': 'bash install.sh',
"     \ }
" 
" let g:LanguageClient_serverCommands = {
"     \ 'c': ['clangd'],
"     \ 'cpp': ['clangd'],
"     \ 'python': ['pyls'],
"     \ 'go': ['gopls'],
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'other': ['./leftimus'],
" \ }

Plug 'neoclide/coc.nvim', {
    \ 'branch': 'release',
    \ 'do' : ':CocInstall coc-rust-analyzer coc-rust'
\ }

" -----------------------------------------------------------------------------
" Language Server Client ------------------------------------------------------
" -----------------------------------------------------------------------------

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'dense-analysis/ale', { 'for': ['ruby'] }
" let g:ale_linters = {
" \   'ruby': ['rubocop'],
" \}

" Plug 'tpope/vim-bundler'
" Plug 'tpope/vim-dispatch'
" Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
"Plug 'psf/black'

"Plug 'fishbullet/deoplete-ruby'
"Plug 'uplus/deoplete-solargraph'

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" Plug 'vim-scripts/SyntaxRange', { 'for': 'markdown' }
"Plug 'vim-syntastic/syntastic'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'd0c-s4vage/vim-morph'
" Plug 'd0c-s4vage/pfp-vim', { 'on': [ 'PfpInit', 'PfpParse' ] }
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'rhysd/vim-grammarous'

" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

Plug 'kien/ctrlp.vim'
" Plug 'davidhalter/jedi-vim'
"Plug 'guns/xterm-color-table.vim'

"php
"Plug 'shawncplus/phpcomplete.vim'

Plug 'ervandew/supertab'
" Plug 'nvie/vim-flake8', { 'for': 'python' }
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes', { 'do': ':AirlineTheme tomorrow'}
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-solarized8'
"Plug 'vim-scripts/AfterColors.vim'
" Plug 'd0c-s4vage/pct-vim', {'branch': 'feature-threads_and_tags'}
"Plug 'd0c-s4vage/pfp-vim'
" Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }

call plug#end()


let mapleader = ","

set laststatus=2

"exe "source ".s:this_dir."/after/colors/jellybeans.vim"
