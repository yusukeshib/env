if type "tmux" > /dev/null; then
  alias a="tmux attach -d -t"
  alias new="tmux new -s"
fi

if type "zellij" > /dev/null; then
  alias z="zellij"
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
alias ok='aws-vault exec -d 8h "${AWS_PROFILE:-fable-hub}" --'
alias okd='aws-vault exec -d 8h fable-development --'
alias okm='aws-vault exec -d 8h fable-management --'
alias okp='aws-vault exec -d 8h fable-production --'

alias kd='okd kubectl --context=development'
alias km='okm kubectl --context=management'
alias kp='okp kubectl --context=production'

alias tf='ok terragrunt'
alias tfa='ok terragrunt apply'
alias tfi='ok terragrunt init'
alias tfiu='ok terragrunt init -upgrade'
alias tfp='ok terragrunt plan'
