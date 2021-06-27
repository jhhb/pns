#!/bin/bash

set -e

# Usage: ./commands-by-frequency.sh
# This script generates a list of commands from ~/.bash_history sorted by their count.
# It can be useful for suggesting commands that should be aliased.

function print_commands_by_frequency() {
  awk '{print $0}' ~/.bash_history | sed 's/^   //' | awk '{print $0}' | sort | uniq -c | sort
  # https://unix.stackexchange.com/questions/5684/history-command-inside-bash-script
  # Doesn't necessarily work -- various hist-related vars may be empty, and history may be disabled in non-interactive shells
  # history | awk '{$1=""; $2=""; $3=""; print $0}' | sed 's/^   //' | awk '{print $0}' | sort | uniq -c | sort | xargs -I {} echo {}
}

print_commands_by_frequency;
