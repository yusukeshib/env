#!/bin/sh

echo '-> Initializing...'

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
find . -maxdepth 1 -not -path '.' -not -path "./.config" -exec ln -s $HOME/env/root/{} $HOME/{} \;

# Symlink all entries in .config
cd $HOME/env/root/.config
find . -maxdepth 1 -not -path '.' -exec ln -s $HOME/env/root/.config/{} $HOME/.config/{} \;

# Symlink all entries in .local/bin
cd $HOME/env/root/.local/bin
find . -maxdepth 1 -not -path '.' -exec ln -s $HOME/env/root/.local/bin/{} $HOME/.local/bin/{} \;

echo '-> Done.'
