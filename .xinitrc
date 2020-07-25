WM=${1:-d}

case $WM in
	g*) ~/.config/initgnome ;;
	h*) exec ~/bin/hacking/dwm/dwm ;;
	d*) ~/.config/initdwm ;;
	*) exec "$WM" || exit 1 ;;
esac

