#!/bin/sh

OPTIONS="IMG:/usr/share/icons/Adwaita/24x24/legacy/starred.png	Favourites
	IMG:/usr/share/icons/Adwaita/24x24/legacy/system-file-manager.png	File Manager	pcmanfm
	IMG:/usr/share/icons/hicolor/24x24/apps/firefox.png	Firefox	firefox
	IMG:/usr/share/icons/hicolor/32x32/apps/PrusaSlicer.png	PrusaSlicer	prusa-slicer
	IMG:/usr/share/icons/hicolor/24x24/apps/steam.png	Steam	steam
"

OPTIONS=$OPTIONS"$(xmenu_path)

"

# xmenu reads literal "\n" and "\t" as newline and tab so they must be converted to "/n" and "/t"
CLIP=$(xclip -o -selection CLIPBOARD | sed -e 's/\\n/\/n/g' -e 's/\\t/\/t/g' | tr -cds "[:print:]" " ")
if [ -n "$CLIP" ]
then
	OPTIONS=$OPTIONS"Clipboard:
	$CLIP
	Clear clipboard	printf '' | xclip -selection CLIPBOARD"

	case "$CLIP" in
	http*twitch.tv/*)
		CUT=${CLIP#*twitch.tv/}
		NAME=${CUT%%/*}
		OPTIONS=$OPTIONS"
	Open stream	tw \"$NAME\""
		;;
	http*)
		OPTIONS=$OPTIONS"
	Open in browser	\$BROWSER \"$CLIP\" &
	Open in mpv	mpv \"$CLIP\" || notify-send \"Invalid video link\""
		;;
	esac

	OPTIONS=$OPTIONS"

"
fi

PLAYERCTLSTATUS=$(playerctl status 2>/dev/null)
if [ -n "$PLAYERCTLSTATUS" ] && [ "$PLAYERCTLSTATUS" != "Stopped" ]
then
	OPTIONS=$OPTIONS"$(playerctl metadata -f '{{playerName}}: {{title}}' 2> /dev/null)
	Previous	playerctl previous
	Play/Pause	playerctl play-pause
	Next	playerctl next

"
fi

if mpc | grep -q -e playing -e paused
then
	NEXT=$(mpc queued -f %title%)

	OPTIONS=$OPTIONS"mpd: $(mpc current -f %title%)
	Previous	mpc prev
	Play/Pause	mpc toggle"
	[ -n "$NEXT" ] && OPTIONS=$OPTIONS"
	Next: $NEXT	mpc next"

	OPTIONS=$OPTIONS"

"
fi

OPTIONS=$OPTIONS"Screenshot
	Full screen	shot
	Select rectangle	shot -s
System
	Reboot	reboot
	Poweroff	poweroff"

printf "$OPTIONS%s" | xmenu | sh &
