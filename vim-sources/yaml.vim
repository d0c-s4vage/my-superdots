function! SetupYaml()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
endfunction
command! -bar SetupYaml call SetupYaml()
autocmd Filetype yaml SetupYaml
autocmd Filetype yml SetupYaml
