typeset -Ag FX FG BG

## Set Colors on BSD system
LSCOLORS="gxfxcxdxbxegedabagacad"
CLICOLOR="YES"

## Load .dir_colors for GNU systems
if command -v dircolors &> /dev/null; then
    test -r "$XDG_CONFIG_HOME/dircolors" && eval $(dircolors "$XDG_CONFIG_HOME"/dircolors)
fi

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done
