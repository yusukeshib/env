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
cd $HOME/env
find . -maxdepth 1 -name '.*' -not -path '.' -not -path './.git' -not -path "./.config" -exec ln -s $HOME/env/{} $HOME/{} \;
# Symlink all entries in .config
cd $HOME/env/.config
find . -maxdepth 1 -not -path '.' -exec ln -s $HOME/env/.config/{} $HOME/.config/{} \;

echo '-> Done.'
