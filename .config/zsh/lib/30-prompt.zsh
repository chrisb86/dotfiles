setopt prompt_subst
autoload -U promptinit
promptinit

# Change user name color to red if logged in as root
if [[ $UID == 0 || $EUID == 0 ]]; then
   PROMPT='%F{red}%n@%m%f '
else
   PROMPT='%F{blue}%n@%m%f '
fi

PROMPT+='%F{yellow}%~%f '

# Change green arrows (⇣⇡) if connection is via ssh
if [[ "${SSH_CONNECTION}" ]]; then
	PROMPT+="%F{green}⇣⇡%f %F{white}〉%f";
else
	PROMPT+="%F{white}〉%f";
fi;

PROMPT+='%{$reset_color%}'
