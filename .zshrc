bindkey -e
unsetopt BEEP

export LANG=en_US.UTF-8
export EDITOR="vi"
export GPG_TTY=$(tty)
export AWS_VAULT_BACKEND=file
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/zinit.zsh"
source "$HOME/.config/zsh/`uname`.zsh"
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
