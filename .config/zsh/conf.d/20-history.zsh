## Command history configuration
export HISTFILE="${ZCACHE}/history"
export HISTSIZE=1000000
export SAVEHIST=${HISTSIZE}
export HISTORY_IGNORE="([bf]g *|disown|cd ..|cd -)"

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE