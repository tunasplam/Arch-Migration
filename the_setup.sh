#!/bin/bash

# This will set up our lovely arch linux installation.
# It will make it so that doing clean installs/refreshes
# to a nice clean base will be both easy and safe to run.
# It will also make it a lot easier to migrate this installation
# to different hardware if needbe.

# This will hopefully be run immediately after arch-install
# and will be the only thing that needs to be run in order
# to set up our system.

# TODO do we need to create a new user?
# TODO how to make sure that this is being run as the new
# user?

# TODO vm arch so that we can test this.

# install all of our needed packages.
# keep this list lexicographic.
# TODO yy to accept additional packages?
sudo pacman -Syu 
amd-ucode \
chromium \
curl \
discord \
flameshot \
git \
julia \
jupyter-notebook \ # theres lots of additional ones here
kitty \
lightdm \ # Possibly replace lightdm
lightdm-gtk-greeter \
neofetch \
nitrogen \
nvidia \
openbox \
papirus-icon-theme \
picom \
pgadmin4 \ # hmmm this should be done in docker?
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

# need to set up zsh user. here is the relevant docs:
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#User-Configuration-Functions
# note that this CANNOT be run as root!
# This part will require user input.
# TODO it is quite possible that this will not need
# to be called bc it may be invoked automatically
# after zsh is installed.
zsh-newuser-install -f

# install env vars script and run it.
git clone https://github.com/tunasplam/arch-env-vars.git
mv ~/arch-env-vars/environment_variables.sh ~
sudo chmod +x environment_variables
source environment_variables.sh
rm -rf ~/arch-env-vars

# install wal-extended.
git clone https://github.com/tunasplam/wal-extended.git

# install our migration git repo so that we can extract
# config files throughout this process.
# TODO hmm this will have to be done in order to run
# this script in the first place. So maybe git will
# need to be setup and then this repo cloned
# before this scirpt is ever even called.
git clone https://github.com/tunasplam/Arch-Migration.git

# replace rcs with custom ones
cp ~/Migration/Configs/.xinitrc ~/.xinitrc
cp ~/Migration/Configs/.zshrc ~/.zshrc
cp ~/Migration/Configs/nano/.nanorc ~/.nanorc

# move over some config files
# TODO some of these folders may not exist at this point
# when testing we will need to determine which ones
# need to be created.
cp ~/Migration/Configs/picom/picom.conf ~/.config/picom
cp ~/Migration/Configs/openbox/* ~/.config/openbox
cp ~/Migration/Configs/nitrogen/* ~/.config/nitrogen
cp ~/Migration/Configs/neofetch/* ~/.config/neofetch
cp ~/Migration/Configs/rofi/* ~/.config/rofi
cp ~/Migration/Configs/Thunar/* ~/.config/Thunar
cp ~/Migration/Configs/tint2/* ~/.config/tint2
cp -rf ~/Migration/Configs/sublime-text ~/.config/sublime-text
# TODO verify that sublime packages were setup.
# TODO set chameleon as default theme for sublime.

# openbox theme
mkdir ~/.themes
mkdir ~/.themes/Chameleon
mkdir ~/.themes/Chameleon/openbox-3
cp ~/Migration/Configs/openbox-3-chameleon-theme ~/.themes/Chameleon/openbox-3

# overwrite all of the polybar stuff.
cp -rf ~/Migration/Configs/polybar ~/.config/polybar/

# move over some utility scripts
cp ~/Migration/wifi.sh ~/wifi.sh
cp ~/Migration/xrandr.sh ~/xrandr.sh
sudo chomd +x ~/wifi.sh
sudo chmod +x ~/xrandr.sh

# replace the nanorc files with our own.
sudo cp -f ~/Migration/Configs/nano/rcs /usr/share/nano/

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

# set zsh as default. probably already done.

# move over our theme to .oh-my-zsh directory.
cp ~/Migration/oh-my-zsh/* ~/.ohmyzsh/themes 

source .zshrc
# TODO confirm ohmyzsh properly set up

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

# set nerd fonts as default.
mkdir ~/.config/fontconfig
cp ~/Migration/Configs/fonts.conf ~/.config/fontconfig
# TODO verify that font is set properly

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

# TODO probably need to do a restart at this point.
# or at least prompt user to do so themselves
# after they have reviewed all of the changes.