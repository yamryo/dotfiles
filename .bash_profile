# .bash_profile
#
# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
# # append to the history file, don't overwrite it
# shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# ----------------------------
#   Programming environments
# ----------------------------

#--- rbenv ---
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
eval "$(rbenv init -)"

#--- pyenv ---
#export PYENV_ROOT=${HOME}/.pyenv
#export PATH=${PYENV_ROOT}/bin:$PATH
#eval "$(pyenv init -)"

#--- jupyter notebook ---
#. /usr/local/miniconda3/etc/profile.d/conda.sh
export SAGE_ROOT="/Applications/SageMath-8.7.app/Contents/Resources/sage"

# Load ~/.bashrc
[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
