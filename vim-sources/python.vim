
let g:virtual_env_dir = expand("~") . "/.vim/python_virtualenv"
let g:virtual_env_reqs = [
    \ "jedi",
    \ "black",
    \ "pylint",
    \ "flake8",
    \ "peewee",
    \ "arrow",
\ ]
function! python#VirtualEnvCreate()
    "let g:python3_host_prog = g:virtual_env_dir . '/bin/python3'

    if !isdirectory(g:virtual_env_dir)
        call python#VirtualEnvInstall()
    endif

    if $VIRTUAL_ENV != ""
        " let the current virtualenv come before our vim virtual env in the
        " PATH
        let $PATH=$VIRTUAL_ENV.'/bin:'.g:virtual_env_dir.'/bin:'.$PATH

        silent! echom "Including vim virtualenv packages in PYTHONPATH: ".glob(g:virtual_env_dir.'/lib/*/site-packages')
        let $PYTHONPATH=glob(g:virtual_env_dir.'/lib/*/site-packages').":".$PYTHONPATH
        let $PYTHONPATH=glob($VIRTUAL_ENV.'/lib/*/site-packages').":".$PYTHONPATH

        call coc#config("python.pythonPath", $VIRTAL_ENV . "/bin/python3")
        silent! echom "setting python.venvPath to ". fnamemodify($VIRTUAL_ENV, ':h')
        call coc#config("python.venvPath", fnamemodify($VIRTUAL_ENV, ':h'))
        silent! echom "setting python.venv to " . fnamemodify($VIRTUAL_ENV, ':t')
        call coc#config("python.venv", fnamemodify($VIRTUAL_ENV, ':t'))
    else
        let $PATH=g:virtual_env_dir.'/bin:'.$PATH
        let activate_this = g:virtual_env_dir . "/bin/activate_this.py"
        silent! execute "python3 exec(open('" . activate_this . "').read(), {'__file__': '" . activate_this . "'}))"
    endif

    " coc settings
    call coc#config("python.formatting.provider", "black")
endfunction

function! python#VirtualEnvInstall()
    if !isdirectory(g:virtual_env_dir)
        silent! execute "!mkdir -p " . shellescape(fnamemodify(g:virtual_env_dir, ":h"))
        silent! echom "Creating virtual environment"
        silent! execute "!python3 -m virtualenv " . shellescape(g:virtual_env_dir)
    endif
    silent! echom "Installing packages"
    silent! execute "!pip install " . join(g:virtual_env_reqs, ' ')
endfunction

function! SetupPython()
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal expandtab
    call python#VirtualEnvCreate()
endfunction

command! -bar SetupPython call SetupPython()
autocmd Filetype python SetupPython

function! PythonAddImportInsertLeave(insert_mode)
    execute "normal! V/import.*$\\n\\s*\\n\<CR>"
    execute "normal! !sort -k 2|uniq\<CR>"
    normal! `mzz"


    " remove import auto-cmd
    autocmd! PythonAddImport *

    if a:insert_mode
        call feedkeys("a")
    endif
endfunction

function! PythonAddImport(insert_mode)
    if &filetype != "python"
        return
    endif

    " look at the first 20 lines - if an import isn't found, add
    " a new import section two lines after the shebang (or docstring)
    let lines = getline(0, 1000000)
    let hasShebang = 0
    let hasDocstring = 0

    let idx = -1
    let firstNoCommentLine = -1
    let firstImportLine = -1
    let inDocstring = 0
    let passedDocstring = 0

    let afterComments = -1
    let afterDocstring = -1
    let firstImport = -1

    while idx < len(lines)-1
        let idx = idx + 1
        let currLine = lines[idx]

        " skip lines that start with a comment
        if currLine =~ "^#"
            continue
        endif

        " record the first line after the leading comments
        if afterComments == -1
            let afterComments = idx
        endif

        if !inDocstring && currLine =~ '^"""'
            let inDocstring = 1
        elseif inDocstring && currLine =~ '"""'
            let inDocstring = 0
            let passedDocstring = 1
            let afterDocstring = idx + 1
        elseif !inDocstring && firstImport == -1 && currLine =~ "^import"
            let firstImport = idx
        endif

    endwhile

    " so we can restore the cursor position later
    normal! mm

    if firstImport != -1
        let importLine = firstImport
        let numNewlines = 1
    elseif afterDocstring != -1
        let importLine = afterDocstring
        let numNewlines = 3
    else
        let importLine = afterComments
        let numNewlines = 2
    endif

    " add the newlines
    call setpos(".", [0, importLine, 0, 0])
    for x in range(numNewlines)
        call append(".", "")
    endfor

    " go to the new line
    call setpos(".", [0, importLine+numNewlines, 0, 0])
    execute "normal! aimport\<space>\<ESC>"

    augroup PythonAddImport
        exec "autocmd InsertLeave <buffer> :call PythonAddImportInsertLeave(" . a:insert_mode . ")"
    augroup end

    startinsert!
endfunction

nnoremap <C-j> :call PythonAddImport(0)<CR>
inoremap <C-j> <ESC>:call PythonAddImport(1)<CR>


" black
let g:black_linelength = 79
"autocmd BufWritePre *.py execute ':Black'

messages clear
