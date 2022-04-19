if type "tmux" > /dev/null; then
  alias a="tmux attach -d -t"
  alias new="tmux new -s"
fi

if type "nvim" > /dev/null; then
  alias vi="nvim"
  alias vim="nvim"
fi

if type "batcat" > /dev/null; then
  alias cat="batcat"
elif type "bat" > /dev/null; then
  alias cat="bat"
fi
