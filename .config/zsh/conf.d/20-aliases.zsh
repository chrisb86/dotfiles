_exists() { (( $+commands[$1] )) }

_exists less && export PAGER=less

# vim
if _exists vim; then
		export EDITOR=vim
		alias vim="vim -p"
fi

# ls/eza
if _exists eza; then
  alias eza="eza --color --icons --git"
  alias ls="eza"
fi

# fetch
if ! _exists fetch; then
  if _exists curl; then
    alias fetch="curl -O"
  elif _exists wget; then
    alias fetch="wget"
  else
    echo "fetch not found."
  fi
fi

unfunction _exists

alias mkdir="mkdir -p"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias google="ping google.com"
alias history="history -i"

case `uname` in
  Darwin)
    # commands for OS X go here
    alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
    alias r="open -a"
  ;;
  Linux)
    # commands for Linux go here
  ;;
  FreeBSD)
    # commands for FreeBSD go here
    alias stl="sockstat -l"
    alias ziostat="cmdwatch -n 1 zpool iostat -vy 1 1"
  ;;
esac
