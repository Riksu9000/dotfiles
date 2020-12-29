#!/bin/sh

#https://www.reddit.com/r/unixporn/comments/k7oght/oc_album_art_with_dunst/getpj3w?utm_source=share&utm_medium=web2x&context=3

music_library="$HOME/music"

mpc -q || exit 1

while true
do
	CURRENT=$(mpc current --wait)
	[ -z "$CURRENT" ] && continue
	ffmpeg -y -i "$(mpc --format "$music_library"/%file% | head -n 1)" /tmp/mpd_cover.jpg > /dev/null 2>&1 && \
	notify-send -i /tmp/mpd_cover.jpg "Now Playing:" "$CURRENT" || \
	notify-send "Now Playing:" "$CURRENT"
	pkill -RTMIN+3 dwmblocks
done

