
function! SetupJava()
    " setlocal tabstop=4
    " setlocal shiftwidth=4
    " setlocal expandtab

    call coc#config("java.home", $JAVA_HOME)
    call coc#config("python.formatting.provider", "black")
endfunction

command! -bar SetupJava call SetupJava()
autocmd Filetype java SetupJava
