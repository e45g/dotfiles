# Do nothing on non-interactive
case $- in
    *i*) ;;
    *) return ;;
esac

# Completion
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Prompt
PS1='\u@\h:\w$ '

# Aliases
alias ls='ls --color=auto'
alias nnn='nnn -e'
alias grep='grep --color=auto'

[ -f "/home/user/.ghcup/env" ] && . "/home/user/.ghcup/env" # ghcup-env
export PATH="$HOME/.cabal/bin:$PATH"

export PATH="/home/user/.cargo/bin:$PATH"
