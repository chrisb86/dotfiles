## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export LC_CTYPE=$LANG
export LC_ALL=de_DE.UTF-8
export IOCAGE_COLOR=TRUE
