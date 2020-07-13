#!/bin/sh

WIDTH=300

# Check updates
notify-send -t 2000 -h string:x-canonical-private-synchronous:updatecheck "Checking for updates"
sudo -A pacman -Sy > /dev/null
notify-send -t 1 -h string:x-canonical-private-synchronous:updatecheck " "

UPDATABLE=$(pacman -Qu | sed '/\[ignored\]/d')

OPTIONS=""
[ -n "$UPDATABLE" ] && OPTIONS+="Install updates
Upgrade and reboot
Upgrade and poweroff
"

OPTIONS+="Restart dwm
Exit dwm
Reboot
Poweroff"

# TODO: Use icons
# ⍇ ⟲ ⟳ ⥁ ⟳ ↻ ↺ ⭮ ⭯ 🔒 

LINECOUNT=$(echo "$OPTIONS" | wc -l)

[ -n "$1" ] && LOCATION=$1 || LOCATION="0"

CHOSEN=$(printf "%s" "$OPTIONS" | rofi -dmenu -i -columns 1 -hide-scrollbar -p "Make a selection" \
-location "$LOCATION" \
-lines "$LINECOUNT" \
-width "$WIDTH")

case $CHOSEN in
	"Install updates")      setsid "$TERMINAL" -e sudo pacman -Syu ;;
	"Upgrade and reboot")   setsid "$TERMINAL" -e sudo pacman -Syu; reboot ;;
	"Upgrade and poweroff") setsid "$TERMINAL" -e sudo pacman -Syu; poweroff ;;
	"Restart dwm") pkill -SIGHUP dwm ;;
	"Exit dwm") pkill -SIGTERM dwm ;;
	"Reboot") reboot ;;
	"Poweroff") poweroff ;;
esac

