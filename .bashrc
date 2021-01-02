alias cp="cp -i" \
dd="dd status=progress oflag=direct" \
doas="$SUDO " \
sudo="$SUDO " \
s="$SUDO " \
gf="git fetch" \
gp="git pull" \
gots='git --git-dir=/home/riku/bin/dotfiles --work-tree=/home/riku/' \
grep="grep --color=auto" \
la="ls -la" \
lb="cd ~/.local/bin" \
ls="ls --color -hNv --group-directories-first" \
make="make -j\$(nproc)" \
myip="curl ipinfo.io/ip" \
nb="newsboat" \
nc="ncmpcpp" \
p="pacman" \
qc="git add -A && git commit -a -m \"\$(date +'%d.%m.%y %H:%M')\"" \
rm="rm -I" \
rr="rm -rfI" \
unxz="unxz -v" \
v="nvim" \
ytdl="youtube-dl" \

[ -r ~/.config/dir_colors ] && eval "$(dircolors ~/.config/dir_colors)"

cd() { builtin cd "$@" && ls; }

up() {
	COUNT=${1:-1}
	while [ "$COUNT" -gt 0 ]
	do
		builtin cd ..
		COUNT=$((COUNT-1))
	done

	ls
}

c() {
	for BG in {40..47}
	do
		printf "\e[%sm   " "$BG"
	done
	printf "\e[0m\n"
}

# background color is intended to be darker than color0
PROMPT_COMMAND=prompt_command
#PS1="\[\e[40;34m\] \w \[\e[0;40m\]> \[\e[0m\] "
prompt_command() {
	PS1=""

	# set title of terminal emulator
	printf "\033]0;%s: %s\007" "${TERM%%-*}" "${PWD/#$HOME/"~"}"

	# SSH server name
	[ -n "$SSH_CLIENT" ] && PS1+="\[\e[40;32m\] \H"

	# If in a git directory, strip working directory and change color
	if BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
	then
		[ "$BRANCH" != "master" ] && PS1+="\[\e[40;96m\] $BRANCH"
		PS1+="\[\e[40;36m\] $(basename $(git rev-parse --show-toplevel))/$(git rev-parse --show-prefix) "
	else
		PS1+="\[\e[40;34m\] \w "
	fi
	PS1+="\[\e[0;40m\]> \[\e[0m\] "
}

