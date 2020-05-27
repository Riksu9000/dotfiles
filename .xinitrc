#       _       _ _
# __  _(_)_ __ (_) |_ _ __ ___
# \ \/ / | '_ \| | __| '__/ __|
#  >  <| | | | | | |_| | | (__
# /_/\_\_|_| |_|_|\__|_|  \___|
# Run on startx

# Background programs
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &  # for merging PRIMARY and CLIPBOARD
dunst &                                # Notification daemon
~/bin/dwmblocks/dwmblocks &

# Set settings
kb.sh           # Keyboard settings script
xrandr --dpi 96
xrdb -merge -I$HOME ~/.Xresources

# Start the window manager
exec ~/bin/dwm/dwm
