#!/bin/sh
#                   __ _ _
#  _ __  _ __ ___  / _(_) | ___
# | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | | | (_) |  _| | |  __/
# | .__/|_|  \___/|_| |_|_|\___|
# |_|

export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'

export TERMINAL="urxvt"
#export TERMINAL="termite"

[ -f ~/.bashrc ] && source ~/.bashrc

PATH="$PATH:$HOME/.scripts"
PATH="$PATH:$HOME/applications"
#PATH=$PATH:/home/riku/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/
