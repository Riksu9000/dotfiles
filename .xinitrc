# Start authentication daemons
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &


# Source files
[ -f ~/.Xresources ] && xrdb ~/.Xresources


# Background programs
autocutsel -fork &
autocutsel -selection PRIMARY -fork &  # for merging PRIMARY and CLIPBOARD
$HOME/.scripts/dwmstatus.sh &  # DWM status bar script


# Set settings
#setxkbmap -layout us,fi
#setxkbmap -option grp:alt_caps_toggle
setxkbmap -layout fi
xrandr --dpi 96
xset r rate 200 30


# Start the window manager
exec dwm

