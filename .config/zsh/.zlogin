## $ZDOTDIR/.zlogin - Contains commands that should be executed only in login shells

## Load config files in $ZSH/lib that for stage 3
for config_file (${ZLIBDIR}/30-*.zsh) source $config_file
unset config_file

## Compile startup files
zwcautocompile

## Print some system info
uname -npsr
uptime
