let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v venv']

let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }

function BrightHighlightOn()
    hi CursorLine term=standout ctermfg=145 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
endfunction

function BrightHighlightOff()
    hi CursorLine guibg=#191919
endfunction
