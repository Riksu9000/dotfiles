#!/bin/bash
#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

[[ $- == *i* ]] && stty -ixon # Disable ctrl-s and ctrl-q

shopt -s autocd # cd by just typing the name of the directory

# Aliases
alias ls="ls --color -hNv --group-directories-first"
alias sudo="sudo "
alias make="make -j$(nproc)"
alias p="pacman"
alias mkdir="mkdir -pv"
alias i3conf="nano ~/.config/i3/config"
alias i3bl="nano ~/.config/i3/i3blocks.conf"
alias c="clear"

function cd {
	builtin cd "$@" && ls
	}

# Prompt
PS1="\[\033[1;32m\]\u@\H \[\033[34m\]\w \[\033[0m\]\$ "

# if running tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

if [ "$TERM" = "linux" ]; then
	# Set virtual console colors from Xresources
	#	for i in $(sed -e 's/\/\/.*$//' -ne 's/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p' $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
	#		echo -en "$i"
	#	done

	alias x="startx"
fi
