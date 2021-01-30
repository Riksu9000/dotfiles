#!/bin/sh

WM=${1:-d}

nvidia-settings --load-config-only

case $WM in
	a*) ~/.config/initawesome ;;
	d*) ~/.config/initdwm ;;
	#g*) XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec gnome-session ;;
	g*) exec gnome-session ;;
	x*) startxfce4 ;;
	*) exec "$WM" || exit 1 ;;
esac

