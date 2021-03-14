alias cp="cp -i" \
dd="dd status=progress" \
doas="doas " \
gr="$BROWSER \$(git remote get-url origin) & disown" \
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
rm="rm -I" \
rr="rm -rfI" \
s="doas " \
sudo="sudo " \
unxz="unxz -v" \
v="nvim" \
ytdl="youtube-dl" \

[ -r ~/.config/dir_colors ] && eval "$(dircolors ~/.config/dir_colors)"

cd() { builtin cd "$@" && ls; }
di() { diff --color=always "$@" | less; }

up() {
	COUNT=${1:-1}
	DIR=$PWD
	while [ "$COUNT" -gt 0 ]
	do
		DIR=${DIR%/*}
		COUNT=$((COUNT-1))
	done

	builtin cd "$DIR/"

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
	if git rev-parse --show-toplevel &> /dev/null
	then
		BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
		[ "$BRANCH" != "master" ] && PS1+="\[\e[40;96m\] $BRANCH"
		PS1+="\[\e[40;36m\] $(basename $(git rev-parse --show-toplevel))/$(git rev-parse --show-prefix) "
	else
		PS1+="\[\e[40;34m\] \w "
	fi
	PS1+="\[\e[0;40m\]> \[\e[0m\] "
}

