[ -r ~/.config/shell/aliasrc ] && source ~/.config/shell/aliasrc
[ -r ~/.config/shell/functions ] && source ~/.config/shell/functions

PS1="%K{black}%F{blue} %~%f Z %k "

autoload -U compinit
compinit

bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select () {
	case $KEYMAP in
	vicmd) printf "\033[1 q" ;; # block
	viins|main) printf "\033[5 q" ;; # beam
	esac
}
zle -N zle-keymap-select

function zle-line-init() {
	# set title of terminal emulator
	printf "\033]0;%s: %s\007" "${TERM%%-*}" "${PWD/#$HOME/"~"}"

	printf "\033[5 q"
}
zle -N zle-line-init

bindkey '^[[P' delete-char

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -a '^e' edit-command-line

# Requires arch package zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
