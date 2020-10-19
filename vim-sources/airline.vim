
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_left_sep = '▙'
"let g:airline_right_sep = ' ▜'

"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"

function! DoAirlineInit()
    AirlineTheme tomorrow
endfunction

autocmd! User AirlineAfterInit call DoAirlineInit()

let g:airline_left_sep="▙▚▝"
let g:airline_right_sep="▖▚▜"

let g:airline#extensions#ale#enabled = 1
