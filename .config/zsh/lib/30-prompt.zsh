setopt prompt_subst
autoload -U promptinit
promptinit

## Print bold red username when UID = 0, else unsername in green
p_user='%(!.%F{red}%B%n%b%f.%F{green}%n%f)'
## Print red # when UID = 0, else @ in blue
p_at='%(!.%F{red}%B#%b%f.%F{blue}@%f)'
## Print hostname in blue
p_host='%F{blue}%m%f'
## Print path in yellow
p_path='%F{yellow}%~%f'
## Print prompt sign in red if the previous command retunend and error, otherwise print it in white
p_pr='%(?.%F{white}.%F{red}) %B〉%b%f'

# Add green arrows (⇣⇡) if connection is via ssh
if [[ "${SSH_CONNECTION}" ]]; then
	p_ssh=" %F{green}⇣⇡%f";
fi;

PS1="$p_user$p_at$p_host$p_ssh $p_path$p_pr"
unset p_at p_user p_host p_path p_pr