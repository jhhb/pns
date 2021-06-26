#!/bin/bash

set -e

function print_commands_by_frequency() {
  awk '{print $0}' ~/.bash_history | sed 's/^   //' | awk '{print $0}' | sort | uniq -c | sort

  # https://unix.stackexchange.com/questions/5684/history-command-inside-bash-script
  # Doesn't work -- various hist-related vars are empty, and history is disabled in non-interactive shells
  # history | awk '{$1=""; $2=""; $3=""; print $0}' | sed 's/^   //' | awk '{print $0}' | sort | uniq -c | sort | xargs -I {} echo {}
}

print_commands_by_frequency;