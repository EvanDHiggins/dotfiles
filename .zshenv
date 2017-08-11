function spotifytoggle() {
  spotify status | grep -i playing 1>/dev/null 2>&1 && spotify pause || spotify play
}

export ZSH=${HOME}/.oh-my-zsh
export GOPATH=${HOME}/golang
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/dotfiles/util:$PATH"
