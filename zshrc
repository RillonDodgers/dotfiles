# EXPORTS
export ZSH="/home/dir/.oh-my-zsh"
export PATH="$PATH:/opt/mssql-tools/bin"
export ADF_ENV=development
export EDITOR=vim

# LOAD VARIABLES FROM .env FILE
if [[ -f ~/.env ]]; then
    export $(cat ~/.env | xargs)
fi

# ZSH SETTINGS
ZSH_THEME="robbyrussell"
plugins=(git python)
source $ZSH/oh-my-zsh.sh

# ALIASES
alias token="echo $GITLAB_TOKEN | xclip -sel clip" # set from .env file
alias ls="ls --color=auto"
alias invault="/opt/adfitech/x86_64/apps/invault -srvr=pdf3"
alias zl="/bin/zsh --login"

# Functions
pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

timestamp () {
    echo $(date '+%Y%m%d%H%M%S')
}

start_cpp_dev () {
    if [ -x "$(command -v xdotool)" ]; then
        cpp_dir=$HOME/workspace/linux-cpp-dev-env
        cd $cpp_dir
        xdotool key "ctrl+shift+parenleft"
        xdotool key "ctrl+shift+leftarrow"
        xdotool key "ctrl+shift+parenright"
        xdotool key "ctrl+shift+leftarrow"
        xdotool key "ctrl+shift+uparrow"
        vagrant ssh manjaro
        xdotool key "ctrl+shift+downarrow"
        vagrant ssh centos
    fi
}

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

eval "$(rbenv init - zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/.rbenv/bin:$PATH"

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
