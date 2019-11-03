let g:gitgutter_realtime = 1

nmap <F10> :GitGutterLineHighlightsToggle<CR>
vmap <F10> :GitGutterLineHighlightsToggle<CR>


function! DetermineGitgutterDiffBase()
    let curr_branch = system("git rev-parse --abbrev-ref HEAD")
    if curr_branch =~ "^feature-" || curr_branch =~ "^bugfix-" || curr_branch =~ "^hotfix-"
        let g:gitgutter_diff_base = "master"
    else
        let g:gitgutter_diff_base = "" 
    endif
    echom "Set diff base to ".g:gitgutter_diff_base.", for branch: ".curr_branch
endfunction

command! -bar DetermineGitgutterDiffBase call DetermineGitgutterDiffBase()
autocmd BufReadPre * DetermineGitgutterDiffBase
