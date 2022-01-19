ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet OMZP::ssh-agent
zinit snippet OMZP::git
zinit snippet PZTM::history
zinit snippet PZTM::ssh
zinit snippet PZTM::gpg
zinit light Aloxaf/fzf-tab
