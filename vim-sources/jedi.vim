let g:jedi#popup_on_dot = 1
let g:jedi#show_call_signatures = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_select_first = 0

function! JediVimTabDefinition()
    let view = winsaveview()
    tabf %
    call winrestview(view)
    call jedi#goto()
endfunction
nnoremap <leader>D :call JediVimTabDefinition()<CR>

function! JediVimGotoDefinition()
    call jedi#goto()
    normal! zz
endfunction
nnoremap <leader>G :call JediVimGotoDefinition()<CR>

function! JediVimTabUsages()
    let view = winsaveview()
    tabf %
    call winrestview(view)
    call jedi#usages()
    ccl
    let a = getqflist()
    call setloclist(0, a, 'r')
    lop
endfunction
nnoremap <leader>F :call JediVimTabUsages()<CR>
