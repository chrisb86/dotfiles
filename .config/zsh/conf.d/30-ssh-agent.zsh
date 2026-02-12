## SSH Agent - Load all keys from ~/.ssh/keys/ on startup

# On macOS, use the system keychain ssh-agent
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS uses a system-wide ssh-agent
    # Just add keys if they're not already loaded
    if [[ -d "$HOME/.ssh/keys" ]]; then
        for key in "$HOME/.ssh/keys"/*; do
            # Skip .pub files and non-existent files
            [[ "$key" == *.pub ]] && continue
            [[ ! -f "$key" ]] && continue
            
            # Check if key is already in agent
            if ! ssh-add -l 2>/dev/null | grep -q "$(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $2}')"; then
                # Add key to agent (macOS will use keychain)
                ssh-add --apple-use-keychain "$key" 2>/dev/null
            fi
        done
    fi
else
    # Linux/BSD: Start ssh-agent if not running
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ( umask 077; ssh-agent -t 1h > "$HOME/.ssh-agent.env" )
    fi
    
    # Source ssh-agent environment
    if [[ ! -S "$SSH_AUTH_SOCK" && -f "$HOME/.ssh-agent.env" ]]; then
        source "$HOME/.ssh-agent.env" >/dev/null
    fi
    
    # Add all private keys from ~/.ssh/keys/
    if [[ -d "$HOME/.ssh/keys" ]]; then
        for key in "$HOME/.ssh/keys"/*; do
            [[ "$key" == *.pub ]] && continue
            [[ ! -f "$key" ]] && continue
            
            if ! ssh-add -l 2>/dev/null | grep -q "$(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $2}')"; then
                ssh-add -t 1h "$key" 2>/dev/null
            fi
        done
    fi
fi
