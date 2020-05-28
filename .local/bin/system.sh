#!/bin/sh

##############
# Dimensions #
##############
WIDTH=300

##############
# Appearance #
##############
FONT="xos4 Terminus 18"

# Linepadding needs to be set depending on the font so the emoji won't get
# clipped vertically
LINEPADDING=8

BG="#282828"; FG="#a89984"; HLBG="#d65d0e"; HLFG="#ebdbb2"
BORDERCOLOR="#504945"
BW=4
PADDING=0
LINEMARGIN=0

# Check updates
notify-send -t 2000 -h string:x-canonical-private-synchronous:updatecheck "Checking for updates"
sudo -A pacman -Sy > /dev/null
notify-send -t 1 -h string:x-canonical-private-synchronous:updatecheck " "

UPDATABLE=$(pacman -Qu | sed '/\[ignored\]/d')

OPTIONS=""
[ -n "$UPDATABLE" ] && OPTIONS+="Upgrade and reboot
Upgrade and poweroff
"

OPTIONS+="Restart dwm
Exit dwm
Reboot
Poweroff"

LINECOUNT=$(echo "$OPTIONS" | wc -l)

CHOSEN=$(printf "%s" "$OPTIONS" | rofi -dmenu -separator-style none -columns 1 -hide-scrollbar \
-lines "$LINECOUNT" \
-bw "$BW" \
-color-normal "0,$FG,0,$HLBG,$HLFG" \
-color-window "$BG, $BORDERCOLOR, $HLBG" \
-font "$FONT" \
-line-margin "$LINEMARGIN" \
-line-padding "$LINEPADDING" \
-p "Make a selection" \
-padding "$PADDING" \
-width "$WIDTH")

case $CHOSEN in
	"Upgrade and reboot")   setsid "$TERMINAL" -e sudo -A pacman -Syu && reboot ;;
	"Upgrade and poweroff") setsid "$TERMINAL" -e sudo -A pacman -Syu && poweroff ;;
	"Restart dwm") pkill -SIGHUP dwm ;;
	"Exit dwm") pkill -SIGTERM dwm ;;
	"Reboot") reboot ;;
	"Poweroff") poweroff ;;
esac

