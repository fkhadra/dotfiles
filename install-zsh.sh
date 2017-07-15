#!/bin/bash

echo "Downloading oh-my-zsh"
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh > ~/install.sh
chmod +x ~/install.sh

#avoid to switch to zsh
sed -i "s/env\szsh//g" ~/install.sh
sh -c ~/install.sh
rm -f ~/install.sh

git clone https://github.com/powerline/fonts.git ~/fonts
# install
sh -c ~/fonts/install.sh
rm -rf ~/fonts


git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git ~/.solarized
sh -c ~/.solarized/install.sh
rm -rf  ~/.solarized
