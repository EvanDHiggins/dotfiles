#!/bin/bash
unlink ${HOME}/.tmux.conf
unlink ${HOME}/.vim
unlink ${HOME}/.zshrc

function deletepath {
echo "About to delete $1"
read -p "Would you like to continue? [Y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]?$ ]]; then
    echo "Deleting $1"
    rm -rf $1
fi
}

deletepath ${HOME}/.vim-install
deletepath ${HOME}/.oh-my-zshrc

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
deletepath ${SCRIPTDIR}

