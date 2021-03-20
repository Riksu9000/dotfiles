[ -r ~/.config/shell/aliasrc ] && source ~/.config/shell/aliasrc
[ -r ~/.config/shell/dir_colors ] && eval "$(dircolors ~/.config/shell/dir_colors)"
[ -r ~/.config/shell/functions ] && source ~/.config/shell/functions

PS1="%K{black}"
[ -n "$SSH_CLIENT" ] && PS1="%F{green} %M"
PS1+="%F{blue} %~%f Z %k "

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
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -a '^e' edit-command-line

# nord theme for syntax
typeset -A ZSH_HIGHLIGHT_STYLES
local STRING="fg=green"
#ZSH_HIGHLIGHT_STYLES[alias]="fg=blue"
ZSH_HIGHLIGHT_STYLES[alias]="fg=white"
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]="fg=magenta"
ZSH_HIGHLIGHT_STYLES[assign]="fg=blue"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[command]="fg=white"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=$STRING
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=$STRING
ZSH_HIGHLIGHT_STYLES[function]="fg=white"
ZSH_HIGHLIGHT_STYLES[path]="fg=white"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=blue"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=$STRING
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red"

# Requires arch package zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
