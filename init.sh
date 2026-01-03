#!/bin/bash

# Clone the repo
if [ ! -d "$HOME/env" ]; then
  echo '-> Cloning the repo...'
  git clone https://github.com/yusukeshibata/env.git $HOME/env
  echo '-> Cloned.'
fi

# Symlink all files in the root directory recursively, mkdir if necessary
cd $HOME/env/root
find . -type f | while read -r file; do
  # Remove leading ./
  rel_path="${file#./}"
  target="$HOME/$rel_path"

  # Create parent directory if it doesn't exist
  parent_dir="$(dirname "$target")"
  mkdir -p "$parent_dir"

  # Create symlink if it doesn't already exist
  if [ ! -e "$target" ]; then
    ln -s "$HOME/env/root/$rel_path" "$target" && echo "Linked: $target"
  fi
done

