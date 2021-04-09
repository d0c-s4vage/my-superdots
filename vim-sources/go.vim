

let g:go_gopls_enabled=0
let g:go_fmt_command='gofmt'
let g:go_mod_fmt_autosave=1

au BufWritePre,FileWritePre *.go :GoFmt
