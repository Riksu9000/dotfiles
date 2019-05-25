#                   __ _ _
#  _ __  _ __ ___  / _(_) | ___
# | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | | | (_) |  _| | |  __/
# | .__/|_|  \___/|_| |_|_|\___|
# |_|
# Run on login

#Set virtual console colors from Xresources
for i in $(sed -e 's/\/\/.*$//' -ne 's/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p' $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
	echo -en "$i"
done
clear
date '+%a %e.%b %H:%M'
echo "$(pacman -Qu | wc -l) packages can be upgraded."
alias x=startx


# Run bashrc for login shell
[ -f ~/.bashrc ] && source ~/.bashrc

# Export options
export EDITOR=vim
export LESS=-R
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'

export TERMINAL="st"


PATH="$PATH:$HOME/.scripts"
PATH="$PATH:$HOME/applications"
