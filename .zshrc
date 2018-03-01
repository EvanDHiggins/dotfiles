# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
type tmuxifier 1>/dev/null && eval "$(tmuxifier init -)"

alias csserver="ssh eh169@csserver.evansville.edu"
alias src="source ~/.zshrc; source ~/.zshenv; tmux source-file ~/.tmux.conf"

if [[ $(uname) == 'Darwin' ]]; then
    alias vim='nvim'
    alias vi='nvim'
    alias vimdiff='nvim -d'
fi

export PATH=$PATH:${HOME}/dotfiles/util

function src() {
  source ~/.zshrc
}

# Adds binding to press C-g and get the man page of 
# the current input line in a new tmux window
function man-lookup() {
    tmux new-window "man ${BUFFER%% *}"
    zle push-line
    zle accept-line
}
zle -N man-lookup man-lookup
bindkey "\eg" man-lookup

alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias g-="git checkout -"
alias gs="git status"
alias gr="git review -R"
alias gpush="git stash"
alias gpop="git stash pop"

ZSH_THEME="af-magic"

HYPHEN_INSENSITIVE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh
for ext in ~/dotfiles/shell-extensions/*.ext.sh; do
    echo "Loading $(basename $ext)"
    source $ext
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#bindkey '"\C-p": vim $(fzf);'
bindkey -s '\C-o' 'vim $(fzf)\n'

source ~/.zshenv
