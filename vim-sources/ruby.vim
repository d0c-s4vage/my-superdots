function! SetupRuby()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
    compiler ruby
endfunction

command! -bar SetupRuby call SetupRuby()
autocmd Filetype ruby SetupRuby
