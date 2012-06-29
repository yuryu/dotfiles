# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

## プロンプトの設定
autoload colors
colors
PROMPT="%{${fg[green]}%}[%n@%m] %~ %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
# RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

# terminal configuration
#
unset LSCOLORS
case "${TERM}" in
    xterm)
        export TERM=xterm-color
        ;;
    kterm)
        export TERM=kterm-color
        # set BackSpace control character
        stty erase
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
esac

setopt share_history
setopt hist_ignore_all_dups hist_save_nodups

setopt ignoreeof

setopt auto_pushd
setopt auto_cd auto_remove_slash auto_name_dirs
setopt extended_history hist_ignore_space prompt_subst
setopt extended_glob list_types always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups

autoload -Uz add-zsh-hook
autoload -Uz colors
colors

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git svn hg bzr
  zstyle ':vcs_info:*' formats '(%s)-[%b]'
  zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
  zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
  zstyle ':vcs_info:bzr:*' use-simple true

  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
  function _update_vcs_info_msg() {
      psvar=()
      # LANG=en_US.UTF-8 vcs_info
      LANG=C vcs_info
      [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  }
  add-zsh-hook precmd _update_vcs_info_msg
  RPROMPT="%1(v|%F{green}%1v%f|)"
fi

if [ -e /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

if [ -e $HOME/.zsh/`uname`/rc.zsh ]; then
    source $HOME/.zsh/`uname`/rc.zsh
fi

if [ -e $HOME/.zsh/local/rc.zsh ]; then
    source $HOME/.zsh/local/rc.zsh 
fi

