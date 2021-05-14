#!/bin/sh

set -e

PACKAGELIST=packages

ask() {
	while :
	do
		printf "\033[1m%s [y/N]\033[0m" "$@"
		read -r ANSWER
		case "$ANSWER" in
		[yY]*) return 0 ;;
		[nN]*) return 1 ;;
		"") return 1 ;;
		*) ;;
		esac
	done
}

err() {
	echo "$@"
	exit 1
}

cd "$(dirname "$0")"

[ "$(id -u)" = "0" ] || err "Run as root"
ping -c 1 -W 1 archlinux.org > /dev/null || err "Enable internet connection"

echo "This script installs some stuff.
This script should be safe to run on an old installation, but no guarantees."
ask "Do you want to continue?" || err "Exiting."

if ask "Create user?"
then
	printf "Enter username: "
	read -r USERNAME
	useradd -m -G storage transmission uucp vboxusers video wheel -s /bin/zsh "$USERNAME"
	passwd "$USERNAME"

	ask "Install dotfiles for user?" && HOME=/home/$USERNAME ../filecopy.sh
fi

if ask "Replace sudo with doas?"
then
	pacman -Rns --noconfirm sudo
	ln -s doas /bin/sudo
fi

echo "The rest of the installation is automatic, so sit back and relax"
sleep 2

grep -v '^#' "$PACKAGELIST" | cut -d ' ' -f 1 | xargs pacman --needed --noconfirm -S

sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i 's/^MAKEFLAGS.*/MAKEFLAGS="-j$(nproc)"/' /etc/makepkg.conf

# Enable local hostname resolution
systemctl enable avahi-daemon.service
[ -z "$(grep mdns_minimal /etc/nsswitch.conf)" ] && sed -i 's/resolve\ \[\!UNAVAIL\=return\]\ dns/mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns/' /etc/nsswitch.conf

systemctl enable cups.socket
systemctl enable transmission

cp 30-touchpad.conf /etc/X11/xorg.conf.d/
cp backlight.rules /etc/udev/rules.d/
cp locale.conf /etc/
cp doas.conf /etc/

rm /bin/sh
ln -s dash /bin/sh

echo "Done. Reboot to finish installation."
