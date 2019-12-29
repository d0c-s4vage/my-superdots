

" code completion

" jump to definition
nnoremap <silent><leader>g :call LanguageClient_textDocument_definition()<CR>

" List references
nnoremap <silent><leader>r :call LanguageClient_textDocument_references()<CR>

" rename identifier under the cursor
nnoremap <silent><leader>R :call LanguageClient_textDocument_rename()<CR>

" F5 pops up the LanguageClient context menu
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
