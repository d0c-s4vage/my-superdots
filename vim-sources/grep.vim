"nmap ,g :tabnew<bar>:lgrep -R

" use silver searcher instead of grep
if executable('rg')
  " Use ag over grep
  set grepprg=rg\ --color\ never\ --no-heading\ --line-number

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

function! LGrep(...)
	" find the project root
	let max = 10
	let c = 0
	let dots = "./"
	while c <= max
		if !empty(glob(dots . ".git"))
			break
		else
			let dots = dots . "../"
		endif
		let c += 1
	endwhile

	tabnew

	" if we found the project root (cscope.out), then search from there
	if !empty(glob(dots . ".git"))
		execute "silent! !rg --no-heading --color never --line-number --iglob \\!*cscope* --iglob \\!tags '" . join(a:000, " ") . "' " . dots . " >/tmp/lgrep.txt"
	else
		echo "silent! !rg --no-heading --color never --line-number --iglob \\!*cscope* --iglob \\!tags '" . join(a:000, " ") . "' . >/tmp/lgrep.txt"
	endif

	lf /tmp/lgrep.txt
	lop
	redraw!
endfunction
command! -nargs=+ -complete=file Llgrep call LGrep(<f-args>)
map ,s :Llgrep 
map ,S :execute 'Llgrep '.expand('<cword>')<CR>

nmap <PageUp> :lprev<CR>zz
nmap <PageDown> :lnext<CR>zz
