[ -r ~/.config/shell/aliasrc ] && source ~/.config/shell/aliasrc
[ -r ~/.config/shell/functions ] && source ~/.config/shell/functions

PS1="%K{black}%F{blue} %~%f Z %k "

autoload -U compinit
compinit

bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select () {
	case $KEYMAP in
	vicmd) echo -ne '\e[1 q';; # block
	viins|main) echo -ne '\e[5 q';; # beam
	esac
}
zle -N zle-keymap-select

function zle-line-init() { echo -ne "\e[5 q" }
zle -N zle-line-init

bindkey '^[[P' delete-char

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -a '^e' edit-command-line

# Requires arch package zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
