[ -r ~/.config/shell/aliasrc ] && source ~/.config/shell/aliasrc
[ -r ~/.config/shell/dir_colors ] && eval "$(dircolors ~/.config/shell/dir_colors)"
[ -r ~/.config/shell/functions ] && source ~/.config/shell/functions

PS1="%K{black} "
[ -n "$SSH_CLIENT" ] && PS1="%F{green}%M "
PS1+="%F{blue}%~%f Z %k "

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

bindkey '^?' backward-delete-char

bindkey -v "^[[P" delete-char
bindkey -a "^[[P" delete-char

bindkey -v "^[[1;5C" forward-word
bindkey -a "^[[1;5C" forward-word

bindkey -v "^[[1;5D" backward-word
bindkey -a "^[[1;5D" backward-word

bindkey -v "^[[4~" end-of-line
bindkey -a "^[[4~" end-of-line

bindkey -v "^[[H" beginning-of-line
bindkey -a "^[[H" beginning-of-line

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -a '^e' edit-command-line

# Without this zsh acts weird with links containing a question mark symbol
# is zsh not posix compliant by default?
unsetopt nomatch

# Requires arch package zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
