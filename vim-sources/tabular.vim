

" align text on the specified characters (using tabular)

function! AlignText() range
    let align_chars = input("Align on (default '='): ")
    if align_chars == ""
        let align_chars = "="
    endif
    if align_chars == "/"
        let align_chars = "\\/"
    endif
    call Tabularize("/".align_chars)
endfunction
vmap <leader>A :call AlignText()<CR>
vmap <leader>a: :Tabularize /:<CR>
vmap <leader>a- :Tabularize /-<CR>
vmap <leader>a= :Tabularize /=<CR>
vmap <leader>a, :Tabularize /,<CR>
vmap <leader>a\| :Tabularize /\|<CR>
vmap <leader>a> :Tabularize /><CR>
vmap <leader>a< :Tabularize /<<CR>
vmap <leader>a( :Tabularize /(<CR>
vmap <leader>a) :Tabularize /)<CR>
vmap <leader>a/ :Tabularize /\/<CR>
