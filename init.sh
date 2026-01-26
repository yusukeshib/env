#!/bin/bash

# Parse arguments
FORCE=false
if [ "$1" = "--force" ]; then
  FORCE=true
fi

# Clone the repo
if [ ! -d "$HOME/env" ]; then
  echo '-> Cloning the repo...'
  git clone https://github.com/yusukeshibata/env.git $HOME/env
  echo '-> Cloned.'
fi

# Symlink all files in the directory recursively, mkdir if necessary
cd $HOME/env

# Collect unique directories and remove all broken symlinks in them
find . -type f -not -path "./.gitignore" -not -path "./.git/*" -not -name "README.md" -not -name "init.sh" | xargs -n1 dirname | sort -u | while read -r dir; do
  target_dir="$HOME/${dir#./}"
  if [ -d "$target_dir" ]; then
    find "$target_dir" -maxdepth 1 -type l | while read -r link; do
      [ ! -e "$link" ] && rm "$link" && echo "Removed broken symlink: $link"
    done
  fi
done

find . -type f -not -path "./.gitignore" -not -path "./.git/*" -not -name "README.md" -not -name "init.sh" | while read -r file; do
  # Remove leading ./
  rel_path="${file#./}"
  target="$HOME/$rel_path"

  # Create parent directory if it doesn't exist
  parent_dir="$(dirname "$target")"
  mkdir -p "$parent_dir"

  # If --force is specified, remove existing file/symlink (unless it's already a valid symlink to the correct target)
  if [ "$FORCE" = true ] && [ -e "$target" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$HOME/env/$rel_path" ]; then
      : # Already a valid symlink, skip
    else
      rm -f "$target" && echo "Removed existing file (--force): $target"
    fi
  fi

  # Create symlink if it doesn't already exist
  if [ ! -e "$target" ]; then
    ln -s "$HOME/env/$rel_path" "$target" && echo "Linked: $target"
  fi
done

