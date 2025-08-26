bindkey -e
unsetopt BEEP

export LANG=en_US.UTF-8
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='fd --type f -i'
export ZOXIDE_CMD_OVERRIDE=cd

# This is required to pass all zsh plugins
export PATH="/opt/homebrew/bin:$PATH"

#
# zplug
#

export ZPLUG_HOME=/opt/homebrew/opt/zplug

if [ -d "$ZPLUG_HOME" ]; then
  source $ZPLUG_HOME/init.zsh
    
  zplug "plugins/asdf", from:oh-my-zsh
  zplug "plugins/brew", from:oh-my-zsh
  zplug "plugins/common-aliases", from:oh-my-zsh
  zplug "plugins/direnv", from:oh-my-zsh
  zplug "plugins/eza", from:oh-my-zsh
  zplug "plugins/fzf", from:oh-my-zsh
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/kubectl", from:oh-my-zsh
  zplug "plugins/starship", from:oh-my-zsh
  zplug "plugins/zoxide", from:oh-my-zsh

  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-completions"
  zplug "Aloxaf/fzf-tab", use:"fzf-tab.plugin.zsh"
  
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  zplug load
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
