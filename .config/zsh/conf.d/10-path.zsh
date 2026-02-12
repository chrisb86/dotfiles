# Set $PATH
# Put only directories in $PATH that exist and remove duplicates
typeset -U path # No duplicates
path=()

_prepath() {
  for dir in "$@"; do
    dir=${dir:A}
    [[ ! -d "$dir" ]] && continue
    path=("$dir" $path)
  done
}

_prepath /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/local/sbin   # System
_prepath /var/lib/flatpak/exports/bin                                    # Flatpak (Linux, system)
_prepath /snap/bin                                                       # Snap (Linux)
_prepath /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin  # Homebrew (Linux)
_prepath /opt/homebrew/bin /opt/homebrew/sbin                           # Homebrew (macOS)
_prepath ~/.local/share/flatpak/exports/bin                               # Flatpak (Linux, user)
_prepath ~/.local/bin ~/bin                                               # $HOME

unfunction _prepath
