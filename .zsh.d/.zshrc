#echo "loading ~/.zsh.d/.zshrc"
# -----------------------------
# PATH and other customize
# -----------------------------
#zmodload zsh/zprof && zprof

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

autoload -Uz compinit && compinit -i

# For miniconda3
conda_script=/usr/local/miniconda3/etc/profile.d/conda.sh 
if [ -e $conda_script ]; then
    source $conda_script
fi

#conda activate base

# -----------------------------
# Plugins managed by Zplugin
# -----------------------------
### Added by Zplugin's installer
export ZPLUGINDIR=$ZDOTDIR/.zplugin
source "$ZPLUGINDIR/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin load momo-lab/zsh-abbrev-alias # 略語を展開する
zplugin load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zplugin load zsh-users/zsh-history-substring-search # history関係

### タイプ補完
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-completions

### others
zplugin load rupa/z
. $ZPLUGINDIR/plugins/rupa---z/z.sh
export _Z_DATA=$ZDOTDIR/.z_data

### OMZ theme
zplugin snippet OMZ::lib/git.zsh # Load OMZ Git library
zplugin snippet OMZ::plugins/git/git.plugin.zsh # Load Git plugin from OMZ
zplugin cdclear -q # <- forget completions provided up to this moment
setopt promptsubst
# Load theme from OMZ
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zplugin snippet OMZ::themes/gnzh.zsh-theme #bira.zsh-theme #dstufft.zsh-theme #

# Load normal Github plugin with theme depending on OMZ Git library
#zplugin light NicoSantangelo/Alpharized

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
export HISTSIZE=100000
export SAVEHIST=100000
setopt hist_ignore_dups
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

# shorten current path in prompt
export PROMPT=$(print $PROMPT | sed -E -e "s|%~|%(5~,%-2~/../%2~,%~)|")

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
