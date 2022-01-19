#!/bin/sh

# [ -d "$HOME/env/.git" ] && echo '-> Already initialized.' && exit 0

echo '-> Initializing...'

git clone https://github.com/yusukeshibata/env.git $HOME/env >/dev/null 2>&1
find $HOME/env -maxdepth 1 -name '.*' -not -path '*.git' -exec ln -Fvs {} $HOME/ \;

echo '-> Done.'
