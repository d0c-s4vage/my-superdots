let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

function! SetupJS()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
endfunction

command! -bar SetupJS call SetupJS()
autocmd Filetype javascript SetupJS
