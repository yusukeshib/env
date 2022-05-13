bindkey -e
unsetopt BEEP

export LANG=en_US.UTF-8
export EDITOR="vi"
export GPG_TTY=$(tty)
export AWS_VAULT_BACKEND=keychain
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# brew
[ -d /opt/homebrew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/zim.zsh"
source "$HOME/.config/zsh/`uname`.zsh"
source "$HOME/.config/zsh/functions.zsh"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# TEMP: asdf
# . /opt/homebrew/opt/asdf/libexec/asdf.sh
# source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# direnv
if type direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# pyenv
if type pyenv &> /dev/null; then
  eval "$(pyenv init --path)"
fi

