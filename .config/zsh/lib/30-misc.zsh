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

## Set some app specific dirs with XDM scheme
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"
export VIMINIT='let $VIMRC="$VIMDOTDIR/vimrc" | source $VIMRC'
export GOPATH="${XDG_DATA_HOME}/go"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"