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
p_pr='%(?.%F{magenta}.%F{red})%B〉%b%f%'

# Add green arrows (⇣⇡) if connection is via ssh
if [[ "${SSH_CONNECTION}" ]]; then
	p_ssh=" %F{green}⇣⇡%f";
fi;

# Transient prompt based on https://github.com/romkatv/powerlevel10k/issues/888#issuecomment-657969840
zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='${nl}$p_pr '
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init

nl=$'\n'
PS1="${nl}$p_user$p_at$p_host$p_ssh $p_path${nl}$p_pr"
#unset p_at p_user p_host p_path p_pr