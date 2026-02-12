#!/bin/sh
# tmux clipboard helper - works locally and over SSH/mosh

set -eu

# Read from stdin
buf=$(cat)

# Try methods in order of preference

# Method 1: Use pbcopy if available (local macOS)
if command -v pbcopy >/dev/null 2>&1; then
  printf '%s' "$buf" | pbcopy
# Method 2: OSC 52 (for mosh/ssh)
elif [ -n "${TMUX:-}" ]; then
  # Get the tmux tty
  tmux_tty=$(tmux display-message -p '#{client_tty}')
  
  # Encode in base64
  encoded=$(printf "%s" "$buf" | base64 | tr -d '\n')
  
  # Send OSC 52 sequence
  printf "\033]52;c;%s\a" "$encoded" > "$tmux_tty"
fi
