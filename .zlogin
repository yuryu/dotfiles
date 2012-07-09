#type -p keychain &> /dev/null && eval `keychain --eval`

if [ -e $HOME/.zsh/`uname`/login.zsh ]; then
    source $HOME/.zsh/`uname`/login.zsh
fi

if [ -e $HOME/.zsh/local/login.zsh ]; then
    source $HOME/.zsh/local/login.zsh 
fi
