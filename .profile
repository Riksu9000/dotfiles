#                   __ _ _
#  _ __  _ __ ___  / _(_) | ___
# | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | | | (_) |  _| | |  __/
# | .__/|_|  \___/|_| |_|_|\___|
# |_|
# Run on login

alias x=startx

# Run bashrc for login shell
[ -f ~/.bashrc ] && source ~/.bashrc

PATH="$HOME/bin:$HOME/.local/bin:$PATH"

##############################
# Stop here if login via SSH #
##############################
[ -n "$SSH_CLIENT" ] && return 0


# Gruvbox colorscheme
echo -e "\\e]P01d2021\\e]P1cc241d\\e]P298971a\\e]P3d79921\\e]P4458588\\e]P5b16286\\e]P6689d6a\\e]P7a89984\\e]P8928374\\e]P9fb4934\\e]Pab8bb26\\e]Pbfabd2f\\e]Pc83a598\\e]Pdd3869b\\e]Pe8ec07c\\e]Pfebdbb2"
clear

# Export options
export EDITOR=nvim \
TERMINAL="st" \
BROWSER="firefox" \
_JAVA_AWT_WM_NONREPARENTING=1 \
MOZ_USE_XINPUT2=1 \
LESS=-R \
LESS_TERMCAP_md=$'\e[1;32m' \
LESS_TERMCAP_us=$'\e[1;4;31m' \
LESS_TERMCAP_mb=$'\e[1;31m' \
LESS_TERMCAP_so=$'\e[1;33m' \
LESS_TERMCAP_ue=$'\e[0m' \
LESS_TERMCAP_me=$'\e[0m' \
LESS_TERMCAP_se=$'\e[0m' \
LESSHISTFILE="-" \
QT_QPA_PLATFORMTHEME=gtk2 \
SUDO_ASKPASS=~/.local/bin/askpass \
PF_COL1=6 \
PF_COL3=6 \
PF_INFO="ascii title os kernel uptime pkgs memory palette" \
INPUTRC="~/.config/inputrc" \

# Autostart desktop
#[ "$TERM" == "linux" ] && startx &> /dev/null

