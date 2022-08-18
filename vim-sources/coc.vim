
" don't hide the cursor when showing menus/quick fix lists/etc
let g:coc_disable_transparent_cursor = 1

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>N <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>id <Plug>(coc-definition)
nmap <silent> <leader>it <Plug>(coc-type-definition)
nmap <silent> <leader>ii <Plug>(coc-implementation)
nmap <silent> <leader>ir <Plug>(coc-references)

" Apply diagnostic
nmap <leader>if  <Plug>(coc-fix-current)
nmap <leader>ia  <Plug>(coc-codeaction)

xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Some coc settings in
"   * python.vim
"   * ruby.vim
