## $ZDOTDIR/.zlogin - Contains commands that should be executed only in login shells

## Load config files in $ZSH/lib that for stage 3
for config_file ($ZDOTDIR/lib/30-*.zsh) source $config_file

## Run tasks in background
(
#Initalize and compile completion cache
autoload -Uz compinit

if [ "$(id -u)" -ne 0 ]; then
  compinit  -i # Ignore insecure directories
else
  compinit
fi

## Compile startup files

autoload -Uz zrecompile

for ((i=1; i <= $#fpath; ++i)); do
  dir=$fpath[i]
  zwc=${dir:t}.zwc
  if [[ $dir == (.|..) || $dir == (.|..)/* ]]; then
    continue
  fi
  files=($dir/*(N-.))
  if [[ -w $dir:h && -n $files ]]; then
    files=(${${(M)files%/*/*}#/})
    if ( cd $dir:h &&
         zrecompile -p -U -z $zwc $files ); then
      fpath[i]=$fpath[i].zwc
    fi
  fi
done
)

## If tmux session is nested, source modified config (e.g. for overwriting styles)
if [[ "${SSH_CONNECTION}" ]] && [[ "${TMUX}" ]]; then
  tmux source-file $XDG_CONFIG_HOME/tmux/tmux.nested.conf
fi

## Update or install vim plugins
#vim -i NONE +PlugUpdate +PlugClean! +qal

## Print some system info
uname -npsr
uptime
