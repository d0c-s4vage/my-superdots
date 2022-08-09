
if [ $(id -u) -eq 0 ] ; then
	PS1='\[\e[1;31m\]'
else
	PS1='\[\e[1;30m\]'
fi

PS1="$PS1 lptp [ \\W ]: \[\e[0m\]"

# let's use vi mode in bash
set editing-mode vi
# show if we're in vi insert mode or not
set show-mode-in-prompt on
