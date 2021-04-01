#!/bin/sh

OPTIONS="Poweroff
Reboot
Exit dwm"

# TODO: Use icons ?
# ⍇ ⟲ ⟳ ⥁ ⟳ ↻ ↺ ⭮ ⭯ 🔒⏻

LINECOUNT=$(echo "$OPTIONS" | wc -l)

CHOSEN=$(printf "$OPTIONS%s" | dmenu -l "$LINECOUNT")

case $CHOSEN in
	"Exit dwm") pkill -SIGTERM dwm ;;
	"Poweroff") poweroff ;;
	"Reboot") reboot ;;
esac
