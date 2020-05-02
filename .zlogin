if [[ $UID == 0 || $EUID == 0 ]]; then
  PATH="/root/bin:$PATH"
fi

PATH="$HOME/bin:$PATH"

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

uname -npsr
uptime
