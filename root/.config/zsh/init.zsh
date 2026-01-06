bindkey -e
unsetopt BEEP

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

export PATH="$HOME/.local/bin:/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#
# zplug
#

if uname -r |grep -q 'microsoft' ; then
  export ZPLUG_HOME=/home/linuxbrew/.linuxbrew/opt/zplug
else
  export ZPLUG_HOME=/opt/homebrew/opt/zplug
fi

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


# git worktree shortcut
# with branch name `{git-config-email-prefix}/{name}`
# in the directory `~/worktrees/{git-repo-name}-{git-worktree-name}`
# then, change current directory to the new worktree

function w () {
  if [ -z "$1" ]; then
    echo "Usage: w <worktree-name> [<start-point>]"
    return 1
  fi

  local WORKTREE_NAME="$1"
  local START_POINT="${2:-main}"
  local REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
  local WORKTREE_DIR="$HOME/worktrees/$REPO_NAME-$WORKTREE_NAME"
  local EMAIL_PREFIX=$(git config user.email | cut -d'@' -f1)
  local BRANCH_NAME="$EMAIL_PREFIX/$WORKTREE_NAME"

  git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR" "$START_POINT"
  cd "$WORKTREE_DIR" || return
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
    (( $#sessions )) || return 1
    compadd -Q -a sessions
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

if type "te" > /dev/null; then
  eval "$(te init zsh)"
fi

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
