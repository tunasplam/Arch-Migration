#!/bin/bash

# This will set up our lovely arch linux installation.
# It will make it so that doing clean installs/refreshes
# to a nice clean base will be both easy and safe to run.
# It will also make it a lot easier to migrate this installation
# to different hardware if needbe.

# This will hopefully be run immediately after arch-install
# and will be the only thing that needs to be run in order
# to set up our system.

# obviously this needs to be run as sudo.

# get git set up

# install all of our needed packages.
# keep this list lexicographic.
# TODO yy to accept additional packages?
sudo pacman -Syu 
amd-ucode \
chromium \
discord \
flameshot \
git \
julia \
jupyter-notebook \ # theres lots of additional ones here
kitty \ # set as default.
lightdm \ # Possibly replace lightdm
lightdm-gtk-greeter \
neofetch \
nitrogen \
nvidia \
papirus-icon-theme \
picom \
pgadmin4
polybar \
postgis \
postgres \ # make sure we are doing version 14. config file mirroing epi
python-beautifulsoup4 \
python-matplotlib \
python-matplotlib-inline \
python-numpy \
python-pandas \
python-scikit-learn \
python-scipy \
python-seaborn \
steam \
sublime-text \
tint2 \
thunar \
wget \
xpdf \ 
zsh

# TODO install our migration git repo so that we can extract
# config files throughout this process.

# selenium. will running this script as root screw this up?
# maybe change user at this point?
pip install selenium
python -m selenium
if [ $? -ne 0 ]; then
	echo "Issue installing selenium!"
	exit 1
fi

# ohmyzsh. cmd straight from the website.
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# TODO check that it installed correctly.

# move over zshrc and relevant config files.

# set zsh as default

# move over our theme

# set up our custom theme

# BeautifulDiscord
# https://gist.github.com/Ovyerus/8104dfb71b9792111d85a1b5207ff650
python -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip

# check that beautiful discord worked.
python -m beautifuldiscord
if [ $? -ne 0 ]; then
	echo "Issue installing beautifuldiscord!"
	exit 1
fi

# install and clean up nerd fonts.
git clone https://aur.archlinux.org/nerd-fonts-complete.git
cd nerd-fonts-complete
makepkg
cd ..
rm -rf nerd-fonts-complete\

# TODO set nerd fonts as default.

# install minecraft
git clone https://aur.archlinux.org/minecraft-launcher.git
cd minecraft-launcher
makepkg
cd ..

# TODO move over save files.

# ytmdesktop
git clone https://aur.archlinux.org/ytmdesktop.git
cd ytmdesktop
makepkg
cd ..
rm -rf ytmdesktop\

