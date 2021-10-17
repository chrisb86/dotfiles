_exists() { (( $+commands[$1] )) }

_exists less			&& export PAGER=less

if _exists vim; then
		export EDITOR=vim
		alias vim="vim -p"
fi

unfunction _exists

alias ls="ls -FGhkTv"
alias ll="ls -FGhkTvl"

alias mkdir="mkdir -p"
alias ...="cd ../.."
alias google="ping -c 10240000 google.com"
alias history="history -i"
alias sulast="sudo $(history -p !-1)"
alias ydl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"

case `uname` in
  Darwin)
    # commands for OS X go here
    alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
    alias r="open -a"
    alias fetch="curl -O"
	  alias htop="sudo htop"
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
