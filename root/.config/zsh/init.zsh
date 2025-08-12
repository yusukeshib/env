bindkey -e
unsetopt BEEP

export LANG=en_US.UTF-8
export EDITOR="nvim"

#
# brew
#

[ -d /opt/homebrew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -d /home/linuxbrew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#
# fzf
#

export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source <(fzf --zsh)

#
# zim
#

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

#
# cd replacement
#

if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)"
fi

#
# asdf
#

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

#
# direnv
# ensure compatibility tmux <-> direnv
#

eval "$(direnv hook bash)"
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
  direnv reload
fi

#
# kube
#

PROMPT='$(kube_ps1)'$PROMPT

export PATH="$HOME/.local/bin:$PATH"

#
# Functions
#

function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}

function Gcauto() {
  git commit -m "$(claude -p "Look at the staged git changes and create a summarizing git commit title. Only respond with the title and no affirmation.")"
}

#
# Aliases
#

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


