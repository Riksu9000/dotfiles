# Background programs
dbus-update-activation-environment --systemd DISPLAY
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &  # for merging PRIMARY and CLIPBOARD
dunst &
$HOME/.scripts/dwmstatus.sh &  # DWM status bar script


# Set settings
#setxkbmap -layout us,fi
#setxkbmap -option grp:alt_caps_toggle
setxkbmap -layout fi
xrandr --dpi 96
xset r rate 200 30


# Start the window manager
exec dwm

