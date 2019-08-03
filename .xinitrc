# Background programs
dbus-update-activation-environment --systemd DISPLAY
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &  # for merging PRIMARY and CLIPBOARD
dunst &                                # Notification daemon
synergys
$HOME/.scripts/dwmstatus.sh &          # DWM status bar script


# Set settings
kb.sh           # Keyboard settings script
xrandr --dpi 96


# Start the window manager
exec dwm

