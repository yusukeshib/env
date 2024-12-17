bindkey -e
unsetopt BEEP

export LANG=en_US.UTF-8
export EDITOR="nvim"
export GPG_TTY=$(tty)
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

if [[ -n "$SSH_CONNECTION" ]] ;then
  export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# brew
[ -d /opt/homebrew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -d /home/linuxbrew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/`uname`.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/zim.zsh"

if type "brew" > /dev/null; then
  #asdf
  if [ -d $(brew --prefix)/opt/asdf ]; then
    . $(brew --prefix)/opt/asdf/libexec/asdf.sh
    source "$HOME/.config/asdf-direnv/zshrc"
  fi

  # lldb-vscode
  export LDFLAGS="-L$(brew --prefix)/opt/llvm/lib"
  export CPPFLAGS="-I$(brew --prefix)/opt/llvm/include"
  export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"

  # postgres
  export PATH="$(brew --prefix)/opt/postgresql@13/bin:$PATH"

  # ?
  export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"
  export PKG_CONFIG_PATH="$(brew --prefix)/opt/libarchive/lib/pkgconfig"
fi

# cd replacement
if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)"
fi

if [[ ! -n $ANTHROPIC_API_KEY ]]; then
  export ANTHROPIC_API_KEY=$(op read "op://Personal/avante-anthropic-key/credential")
fi

# atuin setup
if [[ ! -f "$HOME/.atuin/bin/atuin" ]]; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

# Wasmer
export WASMER_DIR="/Users/yusuke/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

[ -d "$HOME/.config/op/" ] && source "$HOME/.config/op/plugins.sh"
[ -d "$HOME/.cargo/" ] && source "$HOME/.cargo/env"
[ -d "$HOME/.deno/" ] && source "$HOME/.deno/env"

