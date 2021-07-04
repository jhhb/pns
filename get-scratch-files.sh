#!/bin/bash

# Usage: Get and copy JetBrains scratch files in a dry run or non-dry run mode.
# ./get-scratch-files.sh <true|false>

JETBRAINS_PATH='/Users/jamesboyle/Library/Application Support/JetBrains/'
OUT_DIR=out/get-scratch-files

# Input: A line like this:
# /Users/jamesboyle/Library/Application Support/JetBrains/WebStorm2020.3/scratches/scratch.ts
# Output:
# WebStorm2020.3
function extract_app_name() {
    echo "$@" | sed 's/.*JetBrains\///' | sed 's/\/scratches.*//'
}

function run() {
    dry_run="$1"
    for file_path in "$JETBRAINS_PATH"*/scratches/*; do # Whitespace-safe but not recursive.
	dir=$(extract_app_name "$file_path")
	file=$(basename "$file_path")
	app_path="$OUT_DIR/$dir"

	if [ "$dry_run" ]; then
  	    echo "[dry_run] mkdir -p $app_path"
	    echo "[dry_run] cp $file_path $app_path/$file"
        else
  	    mkdir -p "$app_path"
	    cp "$file_path" "$app_path/$file"
	fi
    done
}

case "$1" in
    # List patterns for the conditions you want to meet
    false) echo "Running with dry_run=false" && run false;;
    *) echo "Running with dry_run=true" && run true;;  # match everything
esac

