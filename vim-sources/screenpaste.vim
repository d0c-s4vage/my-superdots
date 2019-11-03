"let g:ScreenPasteUseStarRegister = 1
"
"let TMP = tempname()
"let g:ScreenPasteFile = TMP."screenpaste"
"let g:ScreenPasteFileOriginTest = TMP."screenpaste-origin-test"
"let g:ScreenPasteFileMode = TMP."screenpaste.mode"
"
"
"function! screenpaste#GetVisualSelection()
"    let [l_start, c_start] = getpos("v")[1:2]
"    let [l_end, c_end] = getpos(".")[1:2]
"
"    " if the start is actually *after* the end, we need
"    " to swap the start/end positions
"    if l_start > l_end || (l_start == l_end && c_start > c_end)
"        let [l_start, c_start, l_end, c_end] = [l_end, c_end, l_start, c_start]
"    endif
"
"    let lines = getline(l_start, l_end)
"
"    let end_offset = (&selection == 'inclusive' ? 1 : 2)
"    if len(lines) == 0
"        return []
"    elseif len(lines) == 1
"        let lines[0] = lines[0][c_start-1:c_end-end_offset]
"    else
"        let lines[0] = lines[0][c_start-1:]
"        let lines[-1] = lines[-1][:c_end-end_offset]
"    endif
"
"    return lines
"endfunction
"
"
"function! screenpaste#InScreen()
"    if $STY == ""
"        return 0
"    else
"        return 1
"    endif
"endfunction
"
"
"function! screenpaste#ShouldProcess(register)
"    if !screenpaste#InScreen()
"        return 0
"    endif
"
"    if a:register != '"'
"        return 0
"    endif
"
"    return 1
"endfunction
"
"
"function! screenpaste#Paste(command, register)
"    if !screenpaste#ShouldProcess(a:register)
"        return a:command
"    endif
"
"    " write the screen paste buffer to a file
"    silent! call system("screen -X eval 'writebuf ".g:ScreenPasteFileOriginTest."'")
"    let fromScreen = join(readfile(g:ScreenPasteFileOriginTest), "\n")
"
"    let lastFromVim = ""
"    if filereadable(g:ScreenPasteFile)
"        let lastFromVim = join(readfile(g:ScreenPasteFile), "\n")
"    endif
"
"    " if we're still dealing with the contents of something that was
"    " yanked from WITHIN vim (vim -> screen paste register -> disk), then
"    " we know what mode it was yanked in (characterwise, linewise,
"    " blockwise)
"    "
"    " Default mode is characterwise mode
"    let pasteMode = "c"
"    if lastFromVim == fromScreen && filereadable(g:ScreenPasteFileMode)
"        " use the paste mode file to set the mode for the register
"        let pasteMode = join(readfile(g:ScreenPasteFileMode), "\n")
"    endif
"
"    call setreg('"', fromScreen, pasteMode)
"
"    return a:command
"endfunction
"
"
"function! screenpaste#GetLines(command)
"    let lines = []
"    let vmode = "v"
"    if a:command == "y" || a:command == "x"
"        let vmode = visualmode()
"        " @* contains the currently-highlighted text. 
"        if g:ScreenPasteUseStarRegister == 1
"            let lines = split(@*, "\n")
"        else
"            let lines = screenpaste#GetVisualSelection()
"        endif
"    elseif a:command == "yy" || a:command == "dd"
"        " so that when this is pasted, it will be in linemode and not
"        " character mode
"        let vmode = "V"
"        " get the current cursor position
"        let [l_start, c_start] = getpos(".")[1:2]
"        let lines = getline(l_start, l_start)
"    endif
"
"    return [lines, vmode]
"endfunction
"
"
"function! screenpaste#Yank(command, register)
"    if !screenpaste#ShouldProcess(a:register)
"        return a:command
"    endif
"
"    let lines = []
"
"    let [lines, vmode] = screenpaste#GetLines(a:command)
"
"    " write the currently-selected lines into the paste file
"    call writefile(lines, g:ScreenPasteFile, "b")
"    call writefile([vmode], g:ScreenPasteFileMode, "b")
"    " read the paste file into screen's paste register
"    silent! call system("screen -X eval 'readbuf ".g:ScreenPasteFile."'")
"
"    return a:command
"endfunction
"
"
"function! screenpaste#CreateMappings()
"    " put mappings
"    nnoremap <silent> <expr> p screenpaste#Paste('p', v:register)
"
"    " yank-mappings
"    vnoremap <silent> <expr> y screenpaste#Yank('y', v:register)
"    vnoremap <silent> <expr> x screenpaste#Yank('x', v:register)
"    nnoremap <silent> <expr> yy screenpaste#Yank('yy', v:register)
"    nnoremap <silent> <expr> dd screenpaste#Yank('dd', v:register)
"
"    echo "screenpaste is active"
"endfunction
"
"
"function! screenpaste#ClearMappings()
"    nunmap <silent> <expr> p
"    vunmap <silent> <expr> y
"    vunmap <silent> <expr> x
"    nunmap <silent> <expr> yy
"    nunmap <silent> <expr> dd
"    echo "screenpaste is inactive"
"endfunction
"
"let g:ScreenPasteActive = 0
"function! screenpaste#ToggleMappings()
"    if g:ScreenPasteActive == 0
"        let g:ScreenPasteActive = 1
"        call screenpaste#CreateMappings()
"    else
"        let g:ScreenPasteActive = 0
"        call screenpaste#ClearMappings()
"    endif
"endfunction
"
"
"map <C-P> :call screenpaste#ToggleMappings()<CR>
