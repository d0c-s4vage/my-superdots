function! SetupCpp()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
endfunction

command! -bar SetupCpp call SetupCpp()
autocmd Filetype cpp SetupCpp
autocmd Filetype c++ SetupCpp
autocmd Filetype c SetupCpp
