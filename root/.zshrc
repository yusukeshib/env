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
source <(fzf --zsh)

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/`uname`.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/zim.zsh"

if type "brew" > /dev/null; then
  # lldb-vscode
  export LDFLAGS="-L$(brew --prefix)/opt/llvm/lib"
  export CPPFLAGS="-I$(brew --prefix)/opt/llvm/include"
  export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
fi

# cd replacement
if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)"
fi

[ -d "$HOME/.cargo/" ] && source "$HOME/.cargo/env"
[ -d "$HOME/.deno/" ] && source "$HOME/.deno/env"

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# direnv
# ensure compatibility tmux <-> direnv
eval "$(direnv hook bash)"
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
  direnv reload
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
