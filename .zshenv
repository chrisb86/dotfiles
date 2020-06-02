## ~/.zshenv - Should contain commands to set the $PATH and other important environment variables

# Where to look for zsh config
ZDOTDIR=~/.zsh

# Load config files in $ZSH/lib that for stage 1
for config_file ($ZDOTDIR/lib/10-*.zsh) source $config_file
