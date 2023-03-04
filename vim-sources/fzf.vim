
let rg_opts = "--no-ignore --hidden --glob '!venv/' --glob '!venv3/' --glob '!.git/' --glob '!.tox/'"
let $FZF_DEFAULT_COMMAND = "rg --files ".rg_opts

nmap <silent> <c-p> :Files<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading ".rg_opts." --color=always --smart-case -- ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg --column --line-number --no-heading ".rg_opts." --color=always --smart-case -- %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
