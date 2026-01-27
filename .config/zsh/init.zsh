bindkey -e
unsetopt BEEP

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

if type "nvim" > /dev/null; then
  export EDITOR="nvim"
elif type "vim" > /dev/null; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

if type "fd" > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f -i'
fi

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

if type "nixy" > /dev/null; then
  eval "$(nixy config zsh)"
fi

#
# zplug
#

export ZPLUG_HOME=$HOME/.zplug

if [[ ! -d "$ZPLUG_HOME" ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

if [ -d "$ZPLUG_HOME" ]; then
  source $ZPLUG_HOME/init.zsh

  zplug "plugins/asdf", from:oh-my-zsh
  zplug "plugins/brew", from:oh-my-zsh
  zplug "plugins/common-aliases", from:oh-my-zsh

  if type "direnv" > /dev/null; then
    zplug "plugins/direnv", from:oh-my-zsh
  fi

  zplug "plugins/eza", from:oh-my-zsh
  zplug "plugins/fzf", from:oh-my-zsh
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/kubectl", from:oh-my-zsh

  if type "starship" > /dev/null; then
    zplug "plugins/starship", from:oh-my-zsh
  fi

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


#
# Functions
#

function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}


#
# Aliases
#

if type "tmux" > /dev/null; then
  alias a="tmux attach -t"
  alias new="tmux new -s"

  _tmux_attach_sessions() {
    local -a sessions
    sessions=("${(@f)$(tmux ls 2>/dev/null | cut -d: -f1)}")
    (( $#sessions )) || return 1
    compadd -Q -a sessions
  }
  compdef _tmux_attach_sessions a

  zstyle ':fzf-tab:complete:a:*' fzf-preview \
    'echo "Tmux session: $word"; echo; tmux ls | grep --color=always -E "^${word//\*/.*}:" || true'
elif type "zellij" > /dev/null; then
  alias new="zellij -s"

  # Note: defining 'a' as a function is more stable
  a() { zellij attach "$@"; }

  _zellij_attach_sessions() {
    local -a sessions
    # Important: use `list-sessions` (not `ls`)
    sessions=("${(@f)$(zellij list-sessions --short 2>/dev/null)}")
    if (( ! $#sessions )); then
      _message 'no sessions'
      return 1
    fi
    compadd -S '' -Q -a sessions
  }

  # Bind completion function to 'a' (required)
  compdef _zellij_attach_sessions a

  # fzf-tab preview (optional)
  zstyle ':fzf-tab:complete:a:*' fzf-preview \
    'echo "Zellij session: $word"; echo; zellij list-sessions --short | grep --color=always -E "^${word//\*/.*}$" || true'
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


if type "atuin" > /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
  bindkey '^r' atuin-search
fi

if type "git-wt" >/dev/null; then
  alias wt="git wt"
  eval "$(wt --init zsh)"
fi

# dev
if type "sel" > /dev/null; then
  eval "$(sel init zsh)"
fi


