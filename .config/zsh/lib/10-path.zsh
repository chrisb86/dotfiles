# Set $PATH
# Put only directories in $PATH that exist and remove duplicates
typeset -U path  # No duplicates
path=()

_prepath() {
    for dir in "$@"; do
        dir=${dir:A}
        [[ ! -d "$dir" ]] && return
        path=("$dir" $path[@])
    done
}

_prepath /usr/bin /usr/sbin /sbin /Library/Apple/usr/bin  # macOS
_prepath /usr/sbin /sbin # FreeBSD
_prepath /usr/local/bin /bin /usr/local/sbin # General
_prepath /opt/homebrew/bin /opt/homebrew/sbin # Homebrew an Apple Silicon
_prepath ~/.local/bin
_prepath ~/bin

unfunction _prepath
