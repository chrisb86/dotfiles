setopt prompt_subst
autoload -U promptinit
promptinit

# Add green arrows (⇣⇡) if connection is via ssh
if [[ "${SSH_CONNECTION}" ]]; then
	p_ssh=" %F{green}⇣⇡%f";
fi;

p_at='%(!.%F{red}%B#%b%f.%F{blue}@%f)'
p_user='%(!.%F{red}%B%n%b%f.%F{blue}%n%f)'
p_host='%F{blue}%m%f'
p_path='%F{yellow}%~%f'
p_pr='%(?.%F{blue}.%F{red}) 〉%f'

PS1="$p_user$p_at$p_host$p_ssh $p_path$p_pr"
unset p_at p_user p_host p_path p_pr