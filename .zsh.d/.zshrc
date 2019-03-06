#echo "loading ~/.zsh.d/.zshrc"
# -----------------------------
# PATH and other customize
# -----------------------------

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

export HISTFILE=$ZDOTDIR/.zsh_history

autoload -Uz compinit && compinit -i

# -----------------------------
# Plugins managed by zplug
# -----------------------------

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
# export ZSH_HIGHLIGHT_STYLES[path]='fg=081'

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

## Theme (https://github.com/sindresorhus/pure#zplug)
#zplug "mafredri/zsh-async", from:github 
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "themes/gnzh", from:oh-my-zsh, as:theme
#zplug "yous/lime", as:theme

## history関係
zplug "zsh-users/zsh-history-substring-search"

## タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"

## fuzzy finders
zplug "junegunn/fzf-bin", \
    as:command, \
    rename-to:"fzf", \
    from:gh-r
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

zplug "peco/peco", as:command, from:gh-r

## enhancd
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_DIR=$ZDOTDIR/.enhancd
export ENHANCD_COMMAND=cds

## Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

## Then, source plugins and add commands to $PATH
zplug load

# -----------------------------
# User configuration
# -----------------------------

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

export LESS='-g -i -M -R -S -W -z-5 -x4'

# Set personal aliases,
source ~/.bash_aliases

function history-fzf() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -n 1 | eval $tac | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N history-fzf
bindkey '^r' history-fzf
                      
##function peco-history-selection() {
##    BUFFER=`\\history -n 1 | tac -r  | awk '!a[$0]++' | peco`
##    CURSOR=$#BUFFER
##    zle reset-prompt
##}
##zle -N peco-history-selection
## bindkey '^R' peco-history-selection

# shorten current path in prompt
export PROMPT=$(print $PROMPT | sed -E -e "s|%~|%(5~,%-2~/../%2~,%~)|")

# for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:su=41;30:sg=46;30:tw=42;30:tw=42;30:ow=43;30'
zstyle 'completion:*:default' list-colors ${(s.:.)LS_COLORS}
