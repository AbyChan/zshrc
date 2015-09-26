#!/bin/bash

cp ./zgen/zgen.zsh $HOME/.zgen.zsh

if [ -e $HOME/.zshrc ]
then
    cp $HOME/.zshrc $HOME/.zshrc.bak
    cp .zshrc $HOME/.zshrc
    cp ./myzsh/ $HOME/.myzsh
    cp ./bin/* $HOME/bin/
    echo "Notice: Your .zshrc readly exist! I will backup it to .zshrc.bak."
    echo "*****************************************************************"
    echo "*******   Don't install again otherwise cover the backup   ******"
    echo "*****************************************************************"    
else
    echo "copying .zshrc to ~/.zshrc"
fi

echo "\n"
echo "exit this shell and open new to finish install"
