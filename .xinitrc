#!/bin/sh

WM=${1:-d}

case $WM in
	d*) ~/.config/initdwm ;;
	#g*) XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec gnome-session ;;
	g*) exec gnome-session ;;
	*) exec "$WM" || exit 1 ;;
esac
