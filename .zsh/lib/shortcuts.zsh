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
