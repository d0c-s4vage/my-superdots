
#alias vim='gvim -v'
alias ngrep="grep -n"
alias vimin="vim +'set bt=nowrite' -"
alias nossh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias screen_light="screen -c ~/.screenrc-light"
alias screen-light="screen_light"
alias vim-light="vim -c 'colors james-light'"
alias copy='xclip -sel clip'
alias vinagre="vinagre 2>/dev/null"
alias srcsync='rsync --delete -av --exclude "*.pyc" --exclude packer_cache --exclude ".*.swo" --exclude "*.img*" --exclude ".*.swp" --exclude ".*.swn" --exclude ".git"'
alias srcsyncnodel='rsync -av --exclude "*.pyc" --exclude packer_cache --exclude ".*.swo" --exclude "*.img*" --exclude ".*.swp" --exclude ".*.swn" --exclude ".git"'
alias git_first="git rev-list --max-parents=0 HEAD"
