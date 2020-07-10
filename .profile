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

PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/bin/blocks"

##############################
# Stop here if login via SSH #
##############################
[ -n "$SSH_CLIENT" ] && return 0


# Gruvbox colorscheme
echo -e "\\e]P01d2021\\e]P1cc241d\\e]P298971a\\e]P3d79921\\e]P4458588\\e]P5b16286\\e]P6689d6a\\e]P7a89984\\e]P8928374\\e]P9fb4934\\e]Pab8bb26\\e]Pbfabd2f\\e]Pc83a598\\e]Pdd3869b\\e]Pe8ec07c\\e]Pfebdbb2"
clear

# Export options
export XDG_DATA_HOME="$HOME/.local/share" \
XDG_CONFIG_HOME="$HOME/.config" \
XDG_CACHE_HOME="$HOME/.cache" \
EDITOR="nvim" \
VISUAL="nvim" \
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
QT_QPA_PLATFORMTHEME=gtk2 \
SUDO_ASKPASS=~/.local/bin/askpass \

# Declutter home
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc \
WGETRC="$XDG_CONFIG_HOME/wgetrc" \
WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default \
XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority \
CARGO_HOME="$XDG_DATA_HOME"/cargo \
GNUPGHOME="$XDG_DATA_HOME"/gnupg \
ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority \
HISTFILE="$XDG_DATA_HOME"/bash_history \
INPUTRC="~/.config/inputrc" \
LESSHISTFILE="-" \

# Autostart desktop
#[ "$TERM" == "linux" ] && startx &> /dev/null

