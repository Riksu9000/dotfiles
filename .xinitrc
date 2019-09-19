#       _       _ _
# __  _(_)_ __ (_) |_ _ __ ___
# \ \/ / | '_ \| | __| '__/ __|
#  >  <| | | | | | |_| | | (__
# /_/\_\_|_| |_|_|\__|_|  \___|
# Run on startx

# Background programs
dbus-update-activation-environment --systemd DISPLAY
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &  # for merging PRIMARY and CLIPBOARD
dunst &                                # Notification daemon
synergys
$HOME/.local/bin/dwmstatus.sh &          # DWM status bar script
#compton &


# Set settings
kb.sh           # Keyboard settings script
xrandr --dpi 96
#feh --bg-fill wallpaper.jpg


# Start the window manager
exec dwm
#exec awesome

