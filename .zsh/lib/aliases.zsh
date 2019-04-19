alias ll='ls -la'
alias lh='ls -lah'
alias ...='cd ../..'
alias ydl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias google='ping -c 10240000 google.com'
alias foldersize='du -sh'
alias duf='du -sk * | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done'
alias nmap_localnet='nmap -sP 10.0.3.0/24'
alias whois="whois -h whois-servers.net"
alias ltmux="if tmux has-session -t $USER; then tmux attach -d -t $USER; else tmux new -s $USER; fi"
alias ltitle='echo -ne "\033]0;$HOST\007"'

case `uname` in
  Darwin)
    # commands for OS X go here
    alias flushdns='dscacheutil -flushcache && killall -HUP mDNSResponder'
    alias htop='sudo htop'
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
    alias r='open -a'
    alias sulast='sudo $(history -p !-1)'
  ;;
  Linux)
    # commands for Linux go here
  ;;
  FreeBSD)
    # commands for FreeBSD go here
    alias sudo='doas'
  ;;
esac
