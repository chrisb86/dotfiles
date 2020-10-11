## ~/.zshenv - Should contain commands to set the $PATH and other important environment variables

# Set up XDG environment
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}

# Where to look for zsh config
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}

# Load config files in $ZSH/lib that for stage 1
for config_file ($ZDOTDIR/lib/10-*.zsh) source $config_file
