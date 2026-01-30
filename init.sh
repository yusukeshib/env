#!/bin/bash

# Handle import command
if [ "$1" = "import" ]; then
  if [ -z "$2" ]; then
    echo "Usage: ./init.sh import <path>"
    echo "Example: ./init.sh import .config/nixy/"
    exit 1
  fi

  source_dir="$HOME/$2"

  if [ ! -d "$source_dir" ]; then
    echo "Error: $source_dir is not a directory"
    exit 1
  fi

  # Find all regular files (not symlinks, not directories) in source and intermediate dirs
  while IFS= read -r file; do
    # Get relative path from $HOME
    rel_path="${file#$HOME/}"
    target_in_repo="$HOME/env/$rel_path"

    # Skip if already exists in repo
    if [ -e "$target_in_repo" ]; then
      echo "Already in repo: $rel_path"
      continue
    fi

    echo -n "Import $rel_path? [y/N] "
    read -r answer </dev/tty
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
      # Create parent directory in repo if needed
      mkdir -p "$(dirname "$target_in_repo")"
      # Move file to repo
      mv "$file" "$target_in_repo"
      # Create symlink
      ln -s "$target_in_repo" "$file"
      echo "Imported: $rel_path"
    fi
  done < <(
    # Files in source dir (recursive)
    find "$source_dir" -type f
    # Files in intermediate parent dirs (non-recursive)
    dir="$(dirname "$source_dir")"
    while [ "$dir" != "$HOME" ] && [ "$dir" != "/" ]; do
      find "$dir" -maxdepth 1 -type f
      dir="$(dirname "$dir")"
    done
  )

  exit 0
fi

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

# Collect unique directories (including all parent directories) and remove broken symlinks
collect_all_dirs() {
  local dir="$1"
  while [ "$dir" != "." ]; do
    echo "$dir"
    dir="$(dirname "$dir")"
  done
}

find . -type f -not -path "./.gitignore" -not -path "./.git/*" -not -name "README.md" -not -name "init.sh" | xargs -n1 dirname | while read -r dir; do
  collect_all_dirs "$dir"
done | sort -u | while read -r dir; do
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

