#!/bin/sh

echo '-> Initializing...'

# Clone the repo
git clone https://github.com/yusukeshibata/env.git $HOME/env
find $HOME/env -maxdepth 1 -name '.*' -not -path '*.git' -exec ln -Fvs {} $HOME/ \;

echo '-> Done.'
