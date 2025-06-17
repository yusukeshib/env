if type "tmux" > /dev/null; then
  alias a="tmux attach -d -t"
  alias new="tmux new -s"
fi

if type "zoxide" > /dev/null; then
  alias cd="z"
fi

if type "eza" > /dev/null; then
  alias ls="eza"
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

if type "rg" > /dev/null; then
  alias rg="rg --hidden -g '!.git/'"
fi

if type "kubectl" > /dev/null; then
  alias k="kubectl"
fi

if type "kubectx" > /dev/null; then
  alias kx="kubectx"
fi

if type "kubens" > /dev/null; then
  alias kn="kubens"
fi

# Use gh command
if alias gh; then
  unalias gh
fi
