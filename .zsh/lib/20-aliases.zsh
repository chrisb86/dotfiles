_exists() { (( $+commands[$1] )) }

_exists less			&& export PAGER=less
_exists sudo			&& alias doas='sudo'

if _exists vim; then
		export EDITOR=vim
		alias vim="vim -p"
fi

unfunction _exists

alias ls='ls --color=always -h'
alias ll='ls -lah'
alias mkdir='mkdir -p'
alias htop='doas htop'
alias ...='cd ../..'
alias foldersize='du -sh'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias google='ping -c 10240000 google.com'
alias sulast='doas $(history -p !-1)'

case `uname` in
  Darwin)
    # commands for OS X go here
    alias flushdns='dscacheutil -flushcache && killall -HUP mDNSResponder'
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
    alias r='open -a'
    alias ydl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
    alias nmap_localnet='nmap -sP 10.0.3.0/24'
		alias fetch='curl -O'
  ;;
  Linux)
    # commands for Linux go here
  ;;
  FreeBSD)
    # commands for FreeBSD go here
    alias stl="sockstat -l"
  ;;
esac
