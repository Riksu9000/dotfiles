alias p="pacman" \
v="nvim" \
ls="ls --color -hNv --group-directories-first" \
la="ls -la" \
sudo="sudo " \
make="make -j\$(nproc)" \
gots='git --git-dir=/home/riku/bin/dotfiles --work-tree=/home/riku/ ' \
qc="git add -A && git commit -a -m \"\$(date +'%d.%m.%y %H:%M')\"" \
lb="cd ~/.local/bin" \
nb="newsboat && pkill -RTMIN+4 dwmblocks" \
gf="git fetch" \
gp="git pull" \
rr="rm -rf" \

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

# background color is intended to be darker than color0
PROMPT_COMMAND=prompt_command
#PS1="\[\e[40;34m\] \w \[\e[0;40m\]> \[\e[0m\] "
prompt_command() {
	PS1=""

	# set title of terminal emulator
	printf "\033]0;%s: %s\007" "${TERM%%-*}" "${PWD/#$HOME/"~"}"

	# SSH server name
	[ -n "$SSH_CLIENT" ] && PS1+="\[\e[40;32m\] \H"

	GITDIR=$(git rev-parse --show-toplevel --abbrev-ref HEAD --show-prefix 2> /dev/null)

	# If in a git directory, strip working directory and change color
	if [ -n "$GITDIR" ]
	then
		DIR=""
		BRANCH=$(sed -n 2p <<< "$GITDIR")
		[ "$BRANCH" != "master" ] && DIR+="\[\e[40;96m\] $BRANCH"
		DIR+="\[\e[40;36m\] $(basename $(head -n 1 <<< "$GITDIR"))/$(tail -n +3 <<< "$GITDIR") "
	else
		DIR="\[\e[40;34m\] \w "
	fi
	PS1+="$DIR\[\e[0;40m\]> \[\e[0m\] "
}

