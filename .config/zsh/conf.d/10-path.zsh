# Set $PATH
# Put only directories in $PATH that exist and remove duplicates
typeset -U path  # No duplicates
path=()

_prepath() {
    for dir in "$@"; do
        dir=${dir:A}
        [[ ! -d "$dir" ]] && return
        #path=("$dir" $path[@])
        path=("$dir" $path)
    done
}

_prepath /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/local/sbin # BSD and macOS
_prepath /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin # Homebrew on macOS
_prepath ~/bin ~/.local/bin # $HOME

unfunction _prepath
