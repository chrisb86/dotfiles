## $ZDOTDIR/.zshrc - Should be used to set up aliases, functions, keybindings etc.

# Load config files in $ZSH/lib that for stage 2
for config_file ($ZDOTDIR/lib/20-*.zsh) source $config_file
