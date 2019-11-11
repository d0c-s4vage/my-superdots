let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v venv']

let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }

function! BrightHighlightOn()
    if &background == "dark"
        hi CursorLine term=standout ctermfg=145 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
    else
        hi CursorLine term=standout ctermfg=black ctermbg=7 gui=italic guifg=#a0a8b0 guibg=#384048
    endif
endfunction

function! BrightHighlightOff()
    if &background == "dark"
        hi CursorLine guibg=#191919
    else
        hi CursorLine guibg=#191919
    endif
endfunction
