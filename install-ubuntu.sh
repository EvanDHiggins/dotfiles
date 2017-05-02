#!/bin/bash


function linux-vim-install {
    VIMINSTALL=${HOME}/.vim-install/
    VIMSRC=${HOME}/.vim-source/

    echo "You are about to build vim from source. It will be installed to ${VIMINSTALL}."
    read -p "Would you like to continue? [Y/n]" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]?$ ]]; then
        "Defaulting to system vim. Some of this shit might break. Hold on tight."
        VIM_BIN="$(which vim)"
        return
    fi

    sudo apt -y install tmux zsh libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev \
        libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
        python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git cmake

    git clone https://github.com/vim/vim.git $VIMSRC
    cd $VIMSRC
    ./configure --with-features=huge \
               --enable-multibyte \
               --enable-rubyinterp=yes \
               --enable-pythoninterp=yes \
               --with-python-config-dir=/usr/lib/python2.7/`ls /usr/lib/python2.7/ | grep "^config"` \
               --enable-python3interp=yes \
               --with-python3-config-dir=/usr/lib/python3.5/`ls /usr/lib/python3.5/ | grep "^config"` \
               --enable-perlinterp=yes \
               --enable-luainterp=yes \
               --enable-gui=gtk2 --enable-cscope --prefix=$VIMINSTALL

    sudo make install

    VIM_BIN=${VIMINSTALL}/bin/vim
}

function osx-install {
    if ! type "brew" > /dev/null ; then
        echo "Brew does not exist. Installing..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    echo "Installing vim with homebrew..."
    brew update
    brew install vim macvim zsh
    brew link macvim
    VIM_BIN=mvim
}

# Links various config files to their location. Most of these
# go in $HOME. Sometimes dotfiles are expected in ${HOME}/.config
function link-dotfiles {
    $DOT_FILES_DIR=$1
    echo "Linking .zshrc to ${HOME}/.zshrc"
    ln -s ${DOT_FILES_DIR}/.zshrc ${HOME}/.zshrc

    echo "Linking .tmux.conf to ${HOME}/.tmux.conf"
    ln -s ${DOT_FILES_DIR}/.tmux.conf ${HOME}/.tmux.conf

    echo "Linking .vim directory to ${HOME}/.vim"
    ln -s ${DOT_FILES_DIR}/.vim ${HOME}/.vim
}

function main {
    # This will typically be ~/dotfiles
    SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    VIM_BIN=$(which vim)
    DOT_VIM_DIR=${SCRIPTDIR}/.vim

    # Install vim based on system
    if [[ "$(uname -s)" == "Darwin" ]]; then
        osx-vim-install
    else
        linux-vim-install
    fi

    link-dotfiles $SCRIPT_DIR

    echo "Configuring .oh-my-zsh..."
    git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
    chsh -s "$(which zsh)"


    echo "Initializing Vundle..."
    git clone https://github.com/gmarik/Vundle ${DOT_VIM_DIR}/bundle/Vundle.vim
    cd $SCRIPTDIR
    ${VIM_BIN} +PluginInstall +qall


    echo "Setting up YouCompleteMe..."
    echo "Based on past experience this will almost certainly fail."
    cd ${DOT_VIM_DIR}/bundle/YouCompleteMe/
    ./install.py
    cd $HOME
    env zsh
}

main
echo "Done. Who needs an IDE."
