#!/bin/sh

OPTIONS="$(xmenu_path)

"

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
