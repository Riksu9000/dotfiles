#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
# Run on bash start

shopt -s autocd # cd by just typing the name of the directory

# Aliases
alias p="pacman" \
nf="neofetch" \
v="nvim" \
ls="ls --color -hNv --group-directories-first" \
sudo="sudo " \
make="make -j$(nproc)" \
mkdir="mkdir -pv" \
neofetch="neofetch --block_range 0 15" \
gg="cd ~/docs/github/" \
gots='git --git-dir=/home/riku/docs/github/dotfiles --work-tree=/home/riku/ ' \

# "Functions"
cd() { builtin cd "$@" && ls; }

# Unarchive
# Automatically extract archives into folders with the same name
# removes the original file
ua() {
	if [ $(bsdtar -tf $1 | sed '/.*\/./d' | wc -l) -lt 2 ]
	then
		bsdtar -xf $1 || return 1
		return 0
	else
		BN=$(basename $1)
		EXT=${BN##*.}
		DN=$(basename -s .$EXT $BN)
		mkdir $DN
		bsdtar -xf $1 -C $DN || return 1
	fi
}

kp() {
	keepassxc-cli clip $HOME/docs/Database.kdbx $1
}

PROMPT_COMMAND=prompt_command
prompt_command() {
	PS1=""

	# Add clock to linux virtual terminal
	#[ "$TERM" == "linux" ] && PS1+="\[\033[30;107m\] $(date +'%H.%M') "

	# SSH server name
	[ -n "$SSH_CLIENT" ] && PS1+="\[\033[97;41m\] \H "

	# If in a git directory, strip working directory and change color
	if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" == "true" ]
	then
		DIR=$(git rev-parse --show-prefix)
		NAME=$(basename `git rev-parse --show-toplevel`)
		PS1+="\[\033[97;45m\] $NAME/$DIR \[\033[42m\] \$ \[\033[0m\] "
	else
		PS1+="\[\033[97;44m\] \w \[\033[42m\] \$ \[\033[0m\] "
	fi
}

