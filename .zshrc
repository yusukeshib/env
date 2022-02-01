bindkey -e
unsetopt BEEP

export LANG=en_US.UTF-8
export EDITOR="vi"
export GPG_TTY=$(tty)
export AWS_VAULT_BACKEND=file
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/zim.zsh"
source "$HOME/.config/zsh/`uname`.zsh"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

