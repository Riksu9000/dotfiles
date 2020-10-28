#!/bin/sh

WM=${1:-d}

#nvidia-settings --load-config-only

case $WM in
	d*) ~/.config/initdwm ;;
	g*) ~/.config/initgnome ;;
	*) exec "$WM" || exit 1 ;;
esac

