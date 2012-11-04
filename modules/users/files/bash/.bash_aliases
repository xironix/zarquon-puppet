# -- DO NOT EDIT --
# This file is managed by puppet. Any changes will be reverted.

# ls Aliases
alias ls='ls -F --color'
alias ll='ls -l'
alias la='ls -la'
alias l='ls -C'

# Colour grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# vim
if [ "$DISPLAY" ]; then
  alias vi='gvim -p'
  EDITOR='gvim -f'
else
  alias vi='vim -p'
  EDITOR='vim'
fi
