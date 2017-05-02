#!/bin/bash

git clone https://github.com/gmarik/Vundle ~/.vim/bundle/Vundle.vim
cd ~/.vim
vim +PluginInstall +qall

ln -s ~/.vim/.tmux.conf ~/.tmux.conf
