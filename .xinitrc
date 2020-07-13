# Background programs
autocutsel -fork &
autocutsel -selection PRIMARY -fork &  # for merging PRIMARY and CLIPBOARD
dunst &
~/bin/dwmblocks/dwmblocks &

# Set settings
kb.sh
xrdb -merge -I$HOME ~/.config/Xresources
xsetroot -solid "#242933"

# Window manager
exec ~/bin/dwm/dwm
