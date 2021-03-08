function nix_prompt {
	rc=$?
	if [ "$IN_NIX_SHELL" ] ; then
	    main_color="\e[1;34m"
	    main_prefix="‖nix‖ "
	else
	    main_color="\[\e[1;30m\]"
	    main_prefix=""
	fi
	if [ $rc -ne 0 ] ; then
		rc_disp="\e[1;31m\][\\\$?=$rc]${main_color}"
	else
		rc_disp="[\\\$?=0]"
	fi
	PS1="${main_color}${main_prefix}${rc_disp} lptp [ \\W ]: \[\e[0m\]"
}

PROMPT_COMMAND="nix_prompt"

eval "$(direnv hook bash)"

