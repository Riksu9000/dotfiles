# Start authentication daemons
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Source files
[ -f ~/.Xresources ] && xrdb ~/.Xresources

# Background programs
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
udiskie -ans2 &

# Set settings
setxkbmap -layout fi
xrandr --dpi 96

# Start the window manager
exec i3
