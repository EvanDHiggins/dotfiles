# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
export GOPATH=${HOME}/golang
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

if [[ $(uname) == 'Darwin' ]]; then
    alias vim='mvim -v'
    alias vi='mvim -v'
else
    alias vim=${HOME}/.vim-install/bin/vim
    alias vi=${HOME}/.vim-install/bin/vim
fi

export PATH=$PATH:/Users/ehiggins/bin
export PATH=$PATH:${HOME}/dotfiles/util

connectGerrit() {
  [[ $1 ]]    || { echo "No repository specified" >&2; return 1; }
  git submodule update --init;
  git remote add gerrit ssh://gerrit.belvederetrading.com:29418/$1;
  git review -s
}

setupGit() {
  [[ $1 ]]    || { echo "No repository specified" >&2; return 1; }
  git clone ssh://gerrit:29418/$1;
  cd $1;
  connectGerrit $1;
}

function grh() {
  [[ $1 ]] || { echo "Must specify commit #" >&2; return 1; }
  git rebase -i HEAD~$1
}

function makethosegoddamndecoders() {
  LAST="$(PWD)"
  cd ~/git/ExchangeSimulator/HighFrequency/BT.Protocols/BT.Protocols.Scripts/
  if [[ ! -d env ]]; then
    virtualenv env
  fi
  source env/bin/activate
  pip install -r requirements.txt
  python parse_yaml_template_fix.py ../../BT.Execution/BT.Execution.Protocols/CMEFix/YAML/CMEFixMessages.yaml \
                                    ../../BT.Execution/BT.Execution.Protocols/CMEFix/YAML/CMEFix42.yaml \
                                    ../../
  deactivate
  cd ${LAST}
}

function spotifytoggle() {
  spotify status | grep -i playing 1>/dev/null 2>&1 && spotify pause || spotify play
}

ZSH_THEME="af-magic"

HYPHEN_INSENSITIVE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

function tmuxall() {
  for file in ~/.tmuxifier/layouts/*; 
  do 
    tmuxifier load-window "$(basename $file | awk -F '.' '{print $1}')"
  done
}
