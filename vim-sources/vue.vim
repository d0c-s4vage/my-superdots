function! SetupVue()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
endfunction

command! -bar SetupVue call SetupVue()
autocmd Filetype vue SetupVue
