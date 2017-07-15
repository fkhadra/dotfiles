#!/bin/bash

workingDir="$( cd "$( dirname "${0}" )" && pwd )"
backupDir=~/dotfiles-backups

if [ ! -d "$backupDir" ]
then
    echo "Created backup dir: ${backupDir}"
    mkdir $backupDir
fi

cp -f ~/.bash* $backupDir 2> /dev/null
cp -f ~/.git* $backupDir 2> /dev/null
cp -f ~/.zsh* $backupDir 2> /dev/null

curl -fsSL https://bootstrap.pypa.io/get-pip.py > ~/get-pip.py

sudo python ~/get-pip.py
rm -f ~/get-pip.py

echo "Installing powerline status"
sudo pip install powerline-status

requiredPackages="zsh terminator dconf-cli"

for package in ${requiredPackages}
do
    if [ $(dpkg-query -W -f='${Status}' ${package} 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        echo "${package} not installed. Installing ${package} first..."
        sudo apt install ${package}
    fi
done

#setup awesome vim
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

#setup zsh
sh ${workingDir}/install-zsh.sh

#copy all dot files
cp -rf ${workingDir}/.* ~

#cleanup
rm -rf ~/.git ~/install.sh ~/install-zsh.sh

#set defailt shell
chsh -s /bin/zsh
echo "Don't forget to set the correct font into your terminal to fix encoding issue: Meslo regular font"

env zsh
