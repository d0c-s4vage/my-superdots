" backspace over everything in insert mode
" aka       set backspace=2
set backspace=indent,eol,start

set updatetime=250

"set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
"set smartindent
"set smarttab
set smartcase
set pastetoggle=<F12>
set nowrap
set incsearch
set cmdheight=2
set colorcolumn=80

" colors jellybeans
" default to dark background
set termguicolors
set background=dark
colors solarized8

function! MaybeSetRelative()
    if &number
        set relativenumber
    endif
endfunction
function! MaybeClearRelative()
    if &number
        set norelativenumber
    endif
endfunction au WinEnter * :call MaybeSetRelative()
au WinLeave * :call MaybeClearRelative()

syntax enable
set number
set relativenumber

set clipboard+=unnamed

"filetype plugin on

" open file under the cursor in a new tab
nmap <leader>o <C-W>f<C-W>L

" open file under the cursor in the preview window
function! OpenFileInPrevWindow()
    let cfile = expand("<cfile>")
    wincmd p
    execute "edit " . cfile
endfunction
nmap <leader>f :call OpenFileInPrevWindow()<CR>


function! ReplaceWord()
    let curr_word = expand('<cword>')
    let view = winsaveview()
    set hlsearch
    execute 'normal! /'.curr_word."\<CR>"
    let new_word = input("Replace '".curr_word."' with: ")
    execute '%s/\<'.curr_word.'\>/'.new_word.'/g'
    set nohlsearch
    call winrestview(view)
endfunction

" map <leader>R :call ReplaceWord()<CR>

map <leader>c :tabc<CR>



function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv


" if system('git rev-parse --show-toplevel')[0] == "/"
"     function! RegenTags(initing)
"         let currPath = getcwd()
"         let maxLevels = 10
"         let currLevel = 0
" 
"         let projectRoot = system('git rev-parse --show-toplevel')[:-2]
"         let tagsFile = findfile('tags', projectRoot, -1)
"         exec "set tags=".projectRoot."/tags"
" 
"         let currDir = getcwd()
"         exec "cd ".projectRoot
" 
"         if a:initing == 1
"             call system("ctags -R --exclude='*.js' --exclude='*.css' --exclude='*.md' --exclude='*.au3' --exclude='*.json'")
"             echom "Tags regenerated"
"         else
"             call system("ctags -a '".expand("%")."'")
"         endif
" 
"         exec "cd ".currDir
"     endfunction
" 
"     command! TagRegen call RegenTags(1)
" 
"     augroup ctags
"         au!
"         au! BufWritePost * :call RegenTags(0)
"     augroup END
" endif

" nnoremap <silent><leader>g <c-w><c-]><c-w>T



set fillchars+=vert:░

" workaround for annoying KeyboardInterrupt error
let g:python3_host_prog = '/usr/bin/python3'
let g:python2_host_prog = '/usr/bin/python2'

hi CursorColumn cterm=NONE guifg=NONE guibg=#303030
hi CursorLine cterm=NONE guifg=NONE guibg=#303030
set cursorline
set cursorcolumn

hi Normal guibg=#121212
hi LineNr guibg=#212121
hi CursorLineNr guibg=#414141
hi VertSplit guibg=#414141 guifg=#414141
