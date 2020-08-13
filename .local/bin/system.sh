#!/bin/sh

WIDTH=300

# Check updates
notify-send -h string:x-canonical-private-synchronous:updatecheck "Checking for updates"
sudo -A pacman -Sy > /dev/null
UPDATABLE=$(pacman -Qu | sed '/\[ignored\]/d')
notify-send -t 1 -h string:x-canonical-private-synchronous:updatecheck " "

OPTIONS=""

[ -n "$UPDATABLE" ] && OPTIONS="Install updates
Upgrade and reboot
Upgrade and poweroff
"

OPTIONS="$OPTIONS""Restart dwm
Exit dwm
Reboot
Poweroff"

# TODO: Use icons
# ⍇ ⟲ ⟳ ⥁ ⟳ ↻ ↺ ⭮ ⭯ 🔒⏻

LINECOUNT=$(echo "$OPTIONS" | wc -l)

LOCATION=${1:-0}

CHOSEN=$(printf "%s" "$OPTIONS" |
	rofi -dmenu -i -p ">" -location "$LOCATION" -lines "$LINECOUNT" -width "$WIDTH" \
	#dmenu -l "$LINECOUNT" \
)

case $CHOSEN in
	"Install updates") setsid "$TERMINAL" -e sudo pacman -Syu ;;
	"Upgrade and reboot")
		setsid "$TERMINAL" -e sudo pacman -Syu --noconfirm && reboot \
			|| notify-send -u critical "System upgrade failed" "Please fix before shutting down system"
		;;
	"Upgrade and poweroff")
		setsid "$TERMINAL" -e sudo pacman -Syu --noconfirm && poweroff \
			|| notify-send -u critical "System upgrade failed" "Please fix before shutting down system"
		;;
	"Restart dwm") pkill -SIGHUP dwm ;;
	"Exit dwm") pkill -SIGTERM dwm ;;
	"Reboot") reboot ;;
	"Poweroff") poweroff ;;
esac

pkill -RTMIN+20 dwmblocks &
