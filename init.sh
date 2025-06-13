#!/bin/sh

# Clone the repo
if [ ! -d "$HOME/env" ]; then
  echo '-> Cloning the repo...'
  git clone https://github.com/yusukeshibata/env.git $HOME/env
  echo '-> Cloned.'
fi
# Make sure $HOME/.config exists
if [ ! -d "$HOME/.config" ]; then
  mkdir -p $HOME/.config
  echo '-> Created .config dir.' 
fi

# Symlink all entries in the root
cd $HOME/env/root
for item in *; do
  if [[ "$item" != ".config" && ! -e "$HOME/$item" ]]; then
    ln -s "$HOME/env/root/$item" "$HOME/$item" && echo "Linked: $HOME/$item"
  fi
done

# Symlink all entries in .config
cd $HOME/env/root/.config
for item in *; do
  if [[ ! -e "$HOME/.config/$item" ]]; then
    ln -s "$HOME/env/root/.config/$item" "$HOME/.config/$item" && echo "Linked: $HOME/.config/$item"
  fi
done

# Symlink all entries in .local/bin
cd $HOME/env/root/.local/bin
for item in *; do
  if [[ ! -e "$HOME/.local/bin/$item" ]]; then
    ln -s "$HOME/env/root/.local/bin/$item" "$HOME/.local/bin/$item" && echo "Linked: $HOME/.local/bin/$item"
  fi
done

