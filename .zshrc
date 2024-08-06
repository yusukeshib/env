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

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/zim.zsh"
source "$HOME/.config/zsh/`uname`.zsh"
source "$HOME/.config/zsh/functions.zsh"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# lldb-vscode
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
source "$HOME/.config/op/plugins.sh"

# postgres
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

export PKG_CONFIG_PATH="/opt/homebrew/opt/libarchive/lib/pkgconfig"

# Too many open files
ulimit -n 10240

# cd replacement
eval "$(zoxide init zsh)"
