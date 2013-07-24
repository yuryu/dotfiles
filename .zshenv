export LESSCHARSET=utf-8

export PATH=/usr/local/bin:$PATH

if [ -e $HOME/.zsh/`uname`/env.zsh ]; then
    source $HOME/.zsh/`uname`/env.zsh
fi

if [ -e $HOME/.zsh/local/env.zsh ]; then
    source $HOME/.zsh/local/env.zsh 
fi

