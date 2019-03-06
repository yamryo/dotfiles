# .bashrc

#echo 'load ~/.bashrc'

export PS1="[\[\e[1;33m\]\u@\h\[\e[m\]:\[\e[1;32m\]\w\[\e[m\]]$ "
export PROMPT_DIRTRIM=2

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
