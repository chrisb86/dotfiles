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

## npm config
NPM_PACKAGES="${HOME}/.npm-packages"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

## Use vimrc fom XDG config home
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"
export VIMINIT='let $VIMRC="$VIMDOTDIR/vimrc" | source $VIMRC'