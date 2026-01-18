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
find . -type f -not -path "./.git/*" -not -name "README.md" -not -name "init.sh" | while read -r file; do
  # Remove leading ./
  rel_path="${file#./}"
  target="$HOME/$rel_path"

  # Create parent directory if it doesn't exist
  parent_dir="$(dirname "$target")"
  mkdir -p "$parent_dir"

  # Remove broken symlink if it exists
  if [ -L "$target" ] && [ ! -e "$target" ]; then
    rm "$target" && echo "Removed broken symlink: $target"
  fi

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

