let s:this_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! ToggleSaveWithEveryKeystroke()
    if !exists('#SaveWithEveryKeystroke')
        augroup SaveWithEveryKeystroke
            autocmd TextChanged,TextChangedI <buffer> write
        augroup END
        echo "Enabled saving with every keystroke"
    else
        augroup SaveWithEveryKeystroke
            autocmd!
        augroup END
        echo "Disabled saving with every keystroke"
    endif
endfunction
map <leader>AS :call ToggleSaveWithEveryKeystroke()<CR>

