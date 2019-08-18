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
neofetch="neofetch --block_range 0 15 --colors 4 15 15 4 15 15 --ascii_colors 4 4" \
gg="cd ~/docs/github/" \
gots='git --git-dir=/home/riku/docs/github/dotfiles --work-tree=/home/riku/ ' \

# "Functions"
cd() { builtin cd "$@" && ls; }

# Unarchive
# Automatically extract archives into folders with the same name
# removes the original file
ua() {
	BN=$(basename $1)
	EXT=${BN##*.}
	DN=$(basename -s .$EXT $BN)
	mkdir $DN
	bsdtar -xf $1 -C $DN || return 1
	rm $1
}
# Prompt
if [ -n "$SSH_CLIENT" ]
then
	PS1="\[\033[97;41m\] \H \[\033[44m\] \w \[\033[42m\] \$ \[\033[0m\] "
else
	PS1="\[\033[97;44m\] \w \[\033[42m\] \$ \[\033[0m\] "
fi
