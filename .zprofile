if [ -e $HOME/.zsh/`uname`/profile.zsh ]; then
    source $HOME/.zsh/`uname`/profile.zsh
fi

if [ -e $HOME/.zsh/local/profile.zsh ]; then
    source $HOME/.zsh/local/profile.zsh 
fi
