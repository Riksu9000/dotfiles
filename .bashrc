[ -r ~/.config/shell/aliasrc ] && source ~/.config/shell/aliasrc
[ -r ~/.config/shell/dir_colors ] && eval "$(dircolors ~/.config/shell/dir_colors)"
[ -r ~/.config/shell/functions ] && source ~/.config/shell/functions

# background color is intended to be darker than color0
#PROMPT_COMMAND=prompt_command
PS1="\[\e[40m\] "
[ -n "$SSH_CLIENT" ] && PS1+="\[\e[32m\]\H "
PS1+="\[\e[34m\]\w \[\e[39m\]> \[\e[0m\] "

prompt_command() {
	PS1="\[\e[40m\] "

	# set title of terminal emulator
	printf "\033]0;%s: %s\007" "${TERM%%-*}" "${PWD/#$HOME/"~"}"

	# SSH server name
	[ -n "$SSH_CLIENT" ] && PS1+="\[\e[32m\]\H "

	# If in a git directory, strip working directory and change color
	if git rev-parse --show-toplevel &> /dev/null
	then
		BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
		[ "$BRANCH" != "master" ] && PS1+="\[\e[36m\]$BRANCH "
		PS1+="\[\e[36m\]$(git rev-parse --show-toplevel | xargs basename)/$(git rev-parse --show-prefix) "
	else
		PS1+="\[\e[34m\]\w "
	fi
	PS1+="\[\e[39m\]> \[\e[0m\] "
}
