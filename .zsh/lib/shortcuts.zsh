# Directory shortcuts
# You can use cd ~x and vim ~x/file instead of cd /very/long/and/often/accessed/path. Some examples:
hash -d bin=$HOME/bin

case `uname` in
  Darwin)
    hash -d hucb=~$HOME/Sites/christianbaer.me
  ;;
  Linux)
    # commands for Linux go here
  ;;
  FreeBSD)
    hash -d etc=/usr/local/etc
    hash -d www=/usr/local/www/ngineerx
  ;;
esac

insert_doas() { zle beginning-of-line; zle -U "doas " }
replace_rm()  { zle beginning-of-line; zle delete-word; zle -U "rm " }

zle -N insert-doas insert_doas
zle -N replace-rm replace_rm

bindkey '^s'    insert-doas
bindkey '^r'    replace-rm
