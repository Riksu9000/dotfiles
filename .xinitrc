dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Start i3
[ -f ~/.Xresources ] && xrdb ~/.Xresources
xrandr --dpi 96
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

exec i3
