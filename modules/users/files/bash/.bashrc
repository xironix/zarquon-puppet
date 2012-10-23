# -- DO NOT EDIT --
# This file is managed by Puppet. Changes will be overwritten.
# Please edit ~/.bashrc.custom instead of this file!

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# change the colour of the prompt if we are a root user
if [ $(id -u) -eq 0 ]; then
	PS1='\[\033[1;31m\]\u\[\033[1;37m\]@\[\033[1;31m\]\h\[\033[1;37m\]:\[\033[0;34m\]\w \[\033[0;36m\]\$ \[\033[0m\]'
else
	PS1='\[\033[1;32m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h\[\033[1;37m\]:\[\033[0;34m\]\w \[\033[0;36m\]\$ \[\033[0m\]'
fi

# Use vim as the default editor
export EDITOR='/usr/bin/vim'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Account holder definitions
if [ -f ~/.bashrc.custom ] ; then
	. ~/.bashrc.custom
fi
