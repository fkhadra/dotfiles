#!/bin/bash

cd ~

curl -fsSL https://bootstrap.pypa.io/get-pip.py > get-pip.py

sudo python get-pip.py
sudo pip install powerline-status

requiredPackages=(zsh terminator dconf-cli)

for package     in "${requiredPackages[@]}"
do
    if [ $(dpkg-query -W -f='${Status}' ${package} 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        echo "${package} not installed. Installing ${package} first..."
        sudo apt install ${package}
    fi
done

echo "Downloading oh-my-zsh"
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh > install.sh
chmod +x install.sh
sed -i "s/env\szsh//g" install.sh
sh -c ./install.sh
sed -i "s/robbyrussell/agnoster/g" ~/.zshrc

git clone https://github.com/powerline/fonts.git
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git ~/.solarized
cd ~/.solarized
./install.sh

rm -rf  ~/.solarized
chsh -s /bin/zsh

echo "Don't forget to set the correct font into your terminal"

env zsh
