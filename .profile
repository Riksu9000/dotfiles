x() { xinit "$1" -- :0 vt"$(fgconsole)"; }

# Run bashrc for login shell
[ -f ~/.bashrc ] && source ~/.bashrc

PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/bin/blocks"

##############################
# Stop here if login via SSH #
##############################
[ -n "$SSH_CLIENT" ] && return 0


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
LESS_TERMCAP_md=$'\e[1;34m' \
LESS_TERMCAP_us=$'\e[1;4;36m' \
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
NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages \

# Autostart desktop
#[ "$TERM" == "linux" ] && startx &> /dev/null

