x() { xinit "$1" -- :0 vt"$(fgconsole)"; }

PATH="$PATH:$HOME/.local/bin"

export BROWSER="firefox" \
EDITOR="nvim" \
LESS=-R \
LESS_TERMCAP_mb=$'\e[1;31m' \
LESS_TERMCAP_md=$'\e[1;34m' \
LESS_TERMCAP_me=$'\e[0m' \
LESS_TERMCAP_se=$'\e[0m' \
LESS_TERMCAP_so=$'\e[1;33m' \
LESS_TERMCAP_ue=$'\e[0m' \
LESS_TERMCAP_us=$'\e[1;4;36m' \
MOZ_USE_XINPUT2=1 \
QT_QPA_PLATFORMTHEME=qt5ct \
SSH_ASKPASS=~/.local/bin/askpass \
SUDO_ASKPASS=~/.local/bin/askpass \
TERMINAL="st" \
VISUAL="nvim" \
XDG_CACHE_HOME="$HOME/.cache" \
XDG_CONFIG_HOME="$HOME/.config" \
XDG_DATA_HOME="$HOME/.local/share" \
_JAVA_AWT_WM_NONREPARENTING=1 \

# Declutter home
export CARGO_HOME="$XDG_DATA_HOME"/cargo \
CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv \
GNUPGHOME="$XDG_DATA_HOME"/gnupg \
GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc \
HISTFILE="$XDG_DATA_HOME"/bash_history \
ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority \
INPUTRC="$HOME/.config/inputrc" \
LESSHISTFILE="-" \
NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages \
PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio \
WGETRC="$XDG_CONFIG_HOME/wgetrc" \
WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default \
XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority \
_JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java \

[ -r ~/.bashrc ] && source ~/.bashrc

# Autostart desktop
#[ "$TERM" == "linux" ] && startx &> /dev/null

