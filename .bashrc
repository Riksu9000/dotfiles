#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

[[ $- == *i* ]] && stty -ixon # Disable ctrl-s and ctrl-q
[ $VTE_VERSION ] && source /etc/profile.d/vte.sh #Source vte.sh if in Virtual Terminal Environment

shopt -s autocd # cd by just typing the name of the directory

# Shorter command
alias p="pacman"
alias nf="neofetch"

# Add options to commands
alias nano="nano --nowrap --linenumbers --zap --atblanks --tabsize=4 --nonewlines --smooth --noconvert --morespace --afterends"
alias ls="ls --color -hNv --group-directories-first"
alias sudo="sudo "
alias make="make -j$(nproc)"
alias mkdir="mkdir -pv"

# "Functions"
alias i3conf="nano ~/.config/i3/config"
alias now="date '+%a %e.%b %H:%M' | figlet -t -f big | lolcat -F 0.2"
alias gg="cd ~/Asiakirjat/GitHub/"
cd() { builtin cd "$@" && ls; }

__make_prompt() {
	local EXIT="$?"

	PS1=""

	if [ "$(git branch 2> /dev/null)" != "" ]; then
		PS1+="\[\033[97;45m\] $(basename $(git remote get-url origin 2> /dev/null) .git)$(pwd | sed "s|$(git rev-parse --show-toplevel 2> /dev/null)||") \[\033[30;107m\] $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //')"
	else
		PS1+="\[\033[97;44m\] \w"
	fi

	PS1+=" \[\033[97;42m\] \$ \[\033[0m\] "
}

# Prompt
#PS1="\[\033[92m\]\u@\H \[\033[94m\]\w \[\033[0m\]\$ "
#PS1="\[\033[98;44m\] \w \[\033[42m\] \$ \[\033[0m\] "
PROMPT_COMMAND=__make_prompt


if [ "$TERM" = "linux" ]; then
	#Set virtual console colors from Xresources
	for i in $(sed -e 's/\/\/.*$//' -ne 's/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p' $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
		echo -en "$i"
	done
	clear
	now
	alias x="startx"
fi
