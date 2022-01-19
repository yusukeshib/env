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
source "$HOME/.config/zsh/zinit.zsh"
source "$HOME/.config/zsh/`uname`.zsh"

# fzf
zicompinit; zicdreplay
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# starship
[ ! -s "/usr/local/bin/starship" ] && sh -c "$(curl -fsSL https://starship.rs/install.sh)"
eval "$(starship init zsh)"

export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
