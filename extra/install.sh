#!/bin/sh

PACKAGELIST=packages

err() {
	echo "$@"
	exit 1
}

set -e

[ "$(id -u)" = "0" ] || err "Run as root"
ping -c 1 -W 1 archlinux.org > /dev/null || err "Enable internet connection"

printf "This script installs some stuff
Do you want to continue? [y/N] "
read -r ANSWER
[ "$ANSWER" != "y" ] && err "Exiting."

unset ANSWER
printf "Create user? [Y/n] "
read -r ANSWER
if [ "$ANSWER" != "n" ]
then
	printf "Enter username: "
	read -r USERNAME
	useradd -m -G storage transmission uucp vboxusers video wheel -s /bin/zsh "$USERNAME"
	passwd "$USERNAME"
fi

unset ANSWER
printf "Replace sudo with doas? [y/N] "
if [ "$ANSWER" = "y" ]
then
	pacman -Rns --noconfirm sudo
	ln -s doas /bin/sudo
fi

printf "The rest of the installation is automatic, so sit back and relax"
sleep 2

xargs pacman --needed --noconfirm -S < "$PACKAGELIST"

# Enable color for pacman
sed -i 's/^#Color/Color/' /etc/pacman.conf

# Enable local hostname resolution
systemctl enable avahi-daemon.service
sed -i 's/resolve\ \[\!UNAVAIL\=return\]\ dns/mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns/' /etc/nsswitch.conf
systemctl enable cups.socket
systemctl enable transmission

cp 30-touchpad.conf /etc/X11/xorg.conf.d/
cp backlight.rules /etc/udev/rules.d/

rm /bin/sh
ln -s dash /bin/sh

echo "permit persist :wheel
permit nopass :wheel cmd pacman args -Sy
permit nopass :storage cmd mount
permit nopass :storage cmd umount" > /etc/doas.conf

echo "Done. Reboot to finish installation."
