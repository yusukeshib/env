if type "zellij" > /dev/null; then
  alias attach="zellij attach"
  alias new="zellij -s"
  alias zls="zellij ls"
  alias a="attach"
  alias n="new"
fi

if type "zoxide" > /dev/null; then
  alias cd="z"
fi

if type "zellij" > /dev/null; then
  alias zls="zellij ls"
  alias za="zellij attach"
  alias zn="zellij -s"
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

# yay!
alias kdv='kubectl --context=dev-view'
alias kde='kubectl --context=dev-edit'
alias kda='kubectl --context=dev-admin'
alias kmv='kubectl --context=mgmt-view'
alias kme='kubectl --context=mgmt-edit'
alias kma='kubectl --context=mgmt-admin'
alias kpv='kubectl --context=prod-view'
alias kpe='kubectl --context=prod-edit'
alias kpa='kubectl --context=prod-admin'

alias tf='terragrunt'
alias tfa='terragrunt apply'
alias tfi='terragrunt init'
alias tfiu='terragrunt init -upgrade'
alias tfp='terragrunt plan'

# Use gh command
if alias gh; then
  unalias gh
fi
