#!/bin/sh

set -e

[ "$(id -u)" = "0" ] && echo "Don't run as root" && exit 1

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
