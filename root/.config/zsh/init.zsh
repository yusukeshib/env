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
# prompt
#

eval "$(starship init zsh)"

#
# fzf
#

export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source <(fzf --zsh)

#
# zplug
#

export ZPLUG_HOME=/opt/homebrew/opt/zplug

if [ -d "$ZPLUG_HOME" ]; then
  source $ZPLUG_HOME/init.zsh
    
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-completions"
  zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/common-aliases", from:oh-my-zsh
  zplug "plugins/kubectl", from:oh-my-zsh
  
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  zplug load
fi


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

eval "$(direnv hook zsh)"
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
  direnv reload
fi

export PATH="$HOME/.local/bin:$PATH"

#
# Functions
#

function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}

function gcauto() {
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

