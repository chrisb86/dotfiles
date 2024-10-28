## Command history configuration
export HISTFILE="${ZCACHE}/history"
export HISTSIZE=1000000000
export SAVEHIST=${HISTSIZE}
export HISTORY_IGNORE="([bf]g *|disown|cd ..|cd -)"

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