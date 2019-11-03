
if [ $(id -u) -eq 0 ] ; then
	PS1='\[\e[1;31m\]'
else
	PS1='\[\e[1;30m\]'
fi

PS1="$PS1 lptp [ \\W ]: \[\e[0m\]"
