#!/bin/sh

[ -d "$HOME/env/.git" ] && echo '-> Already initialized.' && exit 0

echo '-> Initializing...'

git clone https://github.com/yusukeshibata/env.git $HOME/env >/dev/null 2>&1
find $HOME/env -type f -name '*' -exec ln -Fvs {} $HOME/ \;

echo '-> Done.'
