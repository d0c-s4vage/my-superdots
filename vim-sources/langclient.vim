

" code completion

" jump to definition
nnoremap <silent><leader>g :call LanguageClient_textDocument_definition()<CR>

" rename identifier under the cursor
nnoremap <silent><leader>R :call LanguageClient_textDocument_rename()<CR>
