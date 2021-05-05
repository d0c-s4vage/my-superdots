

" code completion

" jump to definition
nnoremap <silent><leader>g :call LanguageClient_textDocument_definition()<CR>

" List references
"nnoremap <silent><leader>r :call LanguageClient_textDocument_references()<CR>

" rename identifier under the cursor
nnoremap <silent><leader>R :call LanguageClient_textDocument_rename()<CR>

" F5 pops up the LanguageClient context menu
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

let g:LanguageClient_semanticHighlightMaps = {}
let g:LanguageClient_semanticHighlightMaps['cpp'] = {
      \ '^entity.name.function.cpp': 'Function',
      \ '^entity.name.function.method.cpp': 'Function',
      \ '^entity.name.function.preprocessor.cpp': 'PreProc',
      \ '^entity.name.namespace.cpp': 'Type',
      \ '^entity.name.type.class.cpp': 'Type',
      \ '^entity.name.type.enum.cpp': 'Type',
      \ '^entity.name.type.template.cpp': 'Type',
      \ '^meta.disabled': 'Comment',
      \ '^variable.other.cpp': 'Variable',
      \ '^variable.other.enummember.cpp': 'Constant',
      \ '^variable.other.field.cpp': 'Variable',
      \ }
let g:LanguageClient_semanticHighlightMaps['c'] = {
      \ '^entity.name.function.cpp': 'Function',
      \ '^entity.name.function.method.cpp': 'Function',
      \ '^entity.name.function.preprocessor.cpp': 'PreProc',
      \ '^entity.name.namespace.cpp': 'Type',
      \ '^entity.name.type.class.cpp': 'Type',
      \ '^entity.name.type.enum.cpp': 'Type',
      \ '^entity.name.type.template.cpp': 'Type',
      \ '^meta.disabled': 'Comment',
      \ '^variable.other.cpp': 'Variable',
      \ '^variable.other.enummember.cpp': 'Constant',
      \ '^variable.other.field.cpp': 'Variable',
      \ }
