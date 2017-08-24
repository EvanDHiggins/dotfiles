#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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
        python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git cmake ctags

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

    make install

    U=$USER
    sudo chown ${U}:${U} ${VIMINSTALL} -R
    VIM_BIN=${VIMINSTALL}/bin/vim
    echo "Cleaning up vim source files..."
    rm -rf ${VIMSRC}
    cd ${SCRIPT_DIR}
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
    mkdir --parents ${HOME}/.config/nvim/
    ln -s ${DOT_FILES_DIR}/init.vim ${HOME}/.config/nvim/init.vim
}

function main {
    # Install vim based on system
    if [[ "$(uname -s)" == "Darwin" ]]; then
        osx-vim-install
    else
        linux-vim-install
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
