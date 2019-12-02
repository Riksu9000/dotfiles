#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
# Run on bash start

# Aliases
alias p="pacman" \
v="nvim" \
ls="ls --color -hNv --group-directories-first" \
sudo="sudo " \
gg="cd ~/docs/github/" \
make="make -j\$(nproc)" \
gots='git --git-dir=/home/riku/docs/github/dotfiles --work-tree=/home/riku/ ' \
qc="git add -A && git commit -a -m \"\$(date +'%d.%m.%y %H:%M')\"" \

# "Functions"
cd() { builtin cd "$@" && ls; }

# Unarchive
# Automatically extract archives into folders with the same name
# removes the original file
ua() {
	# Check if there is only one file/directory at the root of the archive.
	# If so, don't make a directory (Extract here)
	if [ $(bsdtar -tf "$1" | sed '/.*\/./d' | wc -l) -lt 2 ]
	then
		bsdtar -xf "$1" || return 1
	else
		BN=$(basename "$1")
		EXT=${BN##*.}
		DN=$(basename -s ."$EXT" "$BN")
		mkdir "$DN" || return 1
		bsdtar -xf "$1" -C "$DN" || return 1
	fi
	rm "$1"
}

kp() {
	keepassxc-cli clip "$HOME/docs/Database.kdbx" "$1" || return "$?"
	#echo "You have 5 seconds to paste the password"
	sleep 5
	echo | xclip
}

PROMPT_COMMAND=prompt_command
prompt_command() {
	PS1=""

	# SSH server name
	[ -n "$SSH_CLIENT" ] && PS1+="\[\033[97;41m\] \H "

	GITDIR=$(git rev-parse --show-toplevel --abbrev-ref HEAD --show-prefix 2> /dev/null)

	# If in a git directory, strip working directory and change color
	if [ -n "$GITDIR" ]
	then
		DIR=""
		[ "$(printf "%s" "$GITDIR" | sed -n 2p)" != "master" ] && DIR+="\[\033[97;46m\] $(printf "%s" "$GITDIR" | sed -n 2p) "
		DIR+="\[\033[97;45m\] $(basename $(printf "%s" "$GITDIR" | sed -n 1p))/$(printf "%s" "$GITDIR" | sed -n 3p) "
	else
		DIR="\[\033[97;44m\] \w "
	fi
	PS1+="$DIR\[\033[42m\] \$ \[\033[0m\] "
}

