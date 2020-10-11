## ~/.zshenv - Should contain commands to set the $PATH and other important environment variables

# Set up XDG environment
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}

# Where to look for zsh config
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}

# Load config files in $ZSH/lib that for stage 1
for config_file ($ZDOTDIR/lib/10-*.zsh) source $config_file
