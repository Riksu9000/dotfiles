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
pacman="pacman --color always" \
neofetch="neofetch --block_range 0 15" \
gg="cd ~/Asiakirjat/GitHub/" \

# "Functions"
cd() { builtin cd "$@" && ls; }

uz() {
	BN=$(basename -s ".zip" $1)
	mkdir $BN
	bsdtar -xf $1 -C $BN
	rm $1
}

# Prompt
PS1="\[\033[97;44m\] \w \[\033[42m\] \$ \[\033[0m\] "

