## Command history configuration
HISTFILE="${ZCACHE}/history"
HISTSIZE=1000000000
SAVEHIST=1000000000

export HISTTIMEFORMAT="[%F %T] "
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt hist_ignore_dups
setopt hist_verify
setopt incappendhistory
setopt histignorespace
setopt histnostore
setopt share_history
export HISTORY_IGNORE="([bf]g *|disown|cd ..|cd -)"