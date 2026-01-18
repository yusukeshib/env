#!/bin/bash

# Clone the repo
if [ ! -d "$HOME/env" ]; then
  echo '-> Cloning the repo...'
  git clone https://github.com/yusukeshibata/env.git $HOME/env
  echo '-> Cloned.'
fi

# Symlink all files in the directory recursively, mkdir if necessary
cd $HOME/env
find . -type f -not -name "README.md" -not -name "init.sh" | while read -r file; do
  # Remove leading ./
  rel_path="${file#./}"
  target="$HOME/$rel_path"

  # Create parent directory if it doesn't exist
  parent_dir="$(dirname "$target")"
  mkdir -p "$parent_dir"

  # Create symlink if it doesn't already exist
  if [ ! -e "$target" ]; then
    ln -s "$HOME/env/$rel_path" "$target" && echo "Linked: $target"
  fi
done

