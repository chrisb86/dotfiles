setopt prompt_subst
autoload -U promptinit
promptinit

# Change user name color to red if logged in as root
if [[ $UID == 0 || $EUID == 0 ]]; then
   PROMPT='$fg[red]%n@%m '
else
   PROMPT='$fg[blue]%n@%m '
fi

PROMPT+='$fg[yellow]%~ '

# Change green arrows (⇣⇡) if cnnection is via ssh
if [[ "${SSH_TTY}" ]]; then
	PROMPT+="$fg[green]⇣⇡ $fg[white]〉";
else
	PROMPT+="$fg[white]〉";
fi;

PROMPT+='%{$reset_color%}'