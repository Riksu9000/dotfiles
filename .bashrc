#!/bin/bash
#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

stty -ixon # Disable ctrl-s and ctrl-q

shopt -s autocd # cd by just typing the name of the directory

# Aliases
alias ls="ls --color -hN --group-directories-first"
alias sudo="sudo "
alias make="make -j9"
alias p="pacman"
alias mkdir="mkdir -pv"
alias i3conf="nano .config/i3/config"

# Prompt
PS1="\[\033[1;32m\]\u@\H \[\033[34m\]\w \[\033[0m\]\$ "

# if running tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
