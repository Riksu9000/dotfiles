#!/bin/sh

cd "$(dirname "$0")" || exit
mkdir autoload
git clone --depth 1 'https://github.com/junegunn/vim-plug.git' tmp
cp tmp/plug.vim autoload/
nvim -c PlugInstall -c quitall
rm -rf tmp
printf '\nInstallation complete!\n'
rm "$0"
