alias ll='ls -la'
alias lh='ls -lah'
alias ...='cd ../..'
alias ydl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias google='ping -c 10240000 google.com'
alias foldersize='du -sh'
alias nmap_localnet='nmap -sP 192.168.1.0/24'
alias sulast='sudo $(history -p !-1)'
alias whois="whois -h whois-servers.net"
alias ltmux="if tmux has-session -t $USER; then tmux attach -t $USER; else tmux new -s $USER; fi"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
alias r='open -a'
alias htop='sudo htop'
alias flushdns='dscacheutil -flushcache && killall -HUP mDNSResponder'
alias pkg_add='brew install'
alias pkg_search='brew search'
alias pkg_remove='brew remove'
alias pkg_upgrade='brew update && brew upgrade && brew cleanup && brew cask cleanup'