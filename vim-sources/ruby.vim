function! SetupRuby()
    echo "Setting up ruby!"
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
    compiler ruby

    " coc settings
    call coc#config("solargraph.useBundler", "true")
    call coc#config("solargraph.diagnostics", "true")
    call coc#config("solargraph.formatting", "true")
endfunction

command! -bar SetupRuby call SetupRuby()
autocmd Filetype ruby SetupRuby
