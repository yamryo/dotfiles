#echo "loading ~/.zsh.d/.zshrc"
# -----------------------------
# PATH and other customize
# -----------------------------
#zmodload zsh/zprof && zprof

# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

autoload -Uz compinit && compinit -i

typeset -U path PATH

#--- TeXLive ---
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH

##--- rbenv ---
#export PATH="$HOME/.rbenv/bin:$PATH"
#export PATH=/usr/local/sbin:/usr/local/bin:$PATH
#eval "$(rbenv init -)"

#--- Miniconda3 & Jupyter ---
#conda_script=/usr/local/miniconda3/etc/profile.d/conda.sh
#if [ -e $conda_script ]; then
#    source $conda_script
#fi
#conda activate base
#export SAGE_ROOT="/Applications/SageMath-8.7.app/Contents/Resources/sage"

# -----------------------------
# Plugins managed by zinit
# -----------------------------
### Added by zinit's installer
export zinitDIR=$ZDOTDIR/zinit
source "${zinitDIR}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk

zinit load momo-lab/zsh-abbrev-alias # 略語を展開する
zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zinit load zsh-users/zsh-history-substring-search # history関係

### タイプ補完
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

### others
#zinit load rupa/z
#. $zinitDIR/plugins/rupa---z/z.sh
export _Z_DATA=$ZDOTDIR/.z_data
#zinit light "marzocchi/zsh-notify"
zinit ice wait'!0'; zinit light "vintersnow/anyframe"

zinit cdclear -q # <- forget completions provided up to this moment
setopt promptsubst
# Load theme
#zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
#zinit snippet OMZ::themes/gnzh.zsh-theme #bira.zsh-theme #dstufft.zsh-theme #
# プロンプトのテーマを遅延ロード。以下でプロンプトをいじってるので、遅延は停止中[20190525]。
#zinit ice pick'spaceship.zsh' wait'!0'
zinit light 'denysdovhan/spaceship-zsh-theme'

# Load normal Github plugin with theme depending on OMZ Git library
#zinit light NicoSantangelo/Alpharized

## -----------------------------
## User configuration
## -----------------------------

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

export LESS='-g -i -M -R -S -W -z-5 -x4'

# Set personal aliases
source ~/.bash_aliases

# History
export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
#setopt hist_verify
setopt share_history

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

# z.sh with fzf
fzf-z-search() {
  local res=$(z | sort -rn | cut -c 12- | fzf)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N fzf-z-search
bindkey '^J' fzf-z-search
#alias cds=fzf-z-search

## For anyframe
bindkey '^xj' anyframe-widget-cdr
bindkey '^xr' anyframe-widget-execute-history
bindkey '^xi' anyframe-widget-put-history
bindkey '^xk' anyframe-widget-kill
bindkey '^xe' anyframe-widget-insert-git-branch
bindkey '^xb' anyframe-widget-checkout-git-branch

# expressly specify to use fzf
zstyle ":anyframe:selector:" use fzf

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

## Prompt Customization
# shorten current path in prompt
#export PROMPT=$(print $PROMPT | sed -E -e "s|%~|%(7~,%-2~/../%2~,%~)|")
# For spaceship-zsh-theme
export SPACESHIP_PROMPT_ADD_NEWLINE="false"
export PROMPT="╭─ "$PROMPT
export SPACESHIP_CHAR_SYMBOL="╰─➤ "
export SPACESHIP_CHAR_COLOR_SUCCESS=""

# for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:su=41;30:sg=46;30:tw=42;30:tw=42;30:ow=43;30'
zstyle 'completion:*:default' list-colors ${(s.:.)LS_COLORS}

#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
