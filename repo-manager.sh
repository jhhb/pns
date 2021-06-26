#!/bin/bash

set -e

readonly REPOS_DIR="/Users/jamesboyle/code"
readonly MANAGER_DIR="repo-manager/makefiles"

function report_git_untracked_files() {
  for directory in "$REPOS_DIR/"*; do
    if [ -d "$directory/.git" ]; then
      dir_name=$(basename "$directory")

      untracked_files=$(git -C "$directory" ls-files --others --exclude-standard)
      if [ -n "$untracked_files" ]; then
        echo "$directory has untracked_files:"
        echo "$untracked_files"
        echo $'\n'
      fi
    fi
  done
}


# Makefiles
function copy_from_projects() {
  for directory in "$REPOS_DIR/"*; do
    dir_name=$(basename "$directory")
    makefile_path="$directory/Makefile"

    if [ -f "$makefile_path" ]; then
      mkdir -p "$MANAGER_DIR/$dir_name"
      dest_path="repo-manager/makefiles/$dir_name/Makefile"
      cp "$makefile_path" "$dest_path"
      echo "Wrote $dest_path"
    fi
done
}

function copy_to_projects() {
  for directory in "$MANAGER_DIR/"*; do
    dir_name=$(basename "$directory")
    makefile_path="$directory/Makefile"
    dest_path="$REPOS_DIR/$dir_name/Makefile"

    echo "Would copy $makefile_path to $dest_path"
  done
}

copy_from_projects;