#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function linux-neovim-install {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install neovim tmux zsh
    VIM_BIN="$(which nvim)"
}

function require-homebrew {
    if ! type "brew" > /dev/null ; then
        echo "Brew does not exist. Installing..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

function osx-neovim-install {
    require-homebrew

    echo "Installing neovim with homebrew..."
    brew update
    brew install neovim zsh ctags

    # Install tmux with true color support
    brew install https://raw.githubusercontent.com/choppsv1/homebrew-term24/master/tmux.rb

    brew install python3
    pip3 install neovim
    nvim +UpdateRemotePlugins +qall

    VIM_BIN='nvim'
}

# Links various config files to their location. Most of these
# go in $HOME. Sometimes dotfiles are expected in ${HOME}/.config
function link-dotfiles {
    DOT_FILES_DIR=$1
    echo "Linking .zshrc to ${HOME}/.zshrc"
    ln -s ${DOT_FILES_DIR}/.zshrc ${HOME}/.zshrc

    echo "Linking .zshenv to $HOME/.zshenv"
    ln -s ${DOT_FILES_DIR}/.zshenv ${HOME}/.zshenv

    echo "Linking .tmux.conf to ${HOME}/.tmux.conf"
    ln -s ${DOT_FILES_DIR}/.tmux.conf ${HOME}/.tmux.conf

    echo "Linking init.vim"
    mkdir -p ${HOME}/.config/nvim/
    ln -s ${DOT_FILES_DIR}/init.vim ${HOME}/.config/nvim/init.vim
}

function main {
    # Install vim based on system
    if [[ "$(uname -s)" == "Darwin" ]]; then
        osx-neovim-install
    else
        linux-neovim-install
    fi

    link-dotfiles $SCRIPT_DIR

    echo "Configuring .oh-my-zsh..."
    git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh


    echo "Initializing vim-plug"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    cd $SCRIPT_DIR
    ${VIM_BIN} +PlugInstall +qall

    chsh -s "$(which zsh)"
    env zsh
}
main
echo "Done. Who needs an IDE."
