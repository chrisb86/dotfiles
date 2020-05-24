## Command history configuration
HISTFILE=$ZDOTDIR/history
HISTSIZE=40000
SAVEHIST=40000

setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_verify
setopt incappendhistory
setopt histignorespace
setopt histnostore
setopt share_history
HISTORY_IGNORE='([bf]g *|disown|cd ..|cd -)'

# Make up and down arrow take what’s typed on the commandline in to account.

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
