bindkey -e
unsetopt BEEP

alias ls="exa -a"
alias ll="exa -al"
alias a="tmux attach -d -t"
alias new="tmux new -s"
alias vi="nvim"
alias vim="nvim"
alias f="find src -type f | xargs grep"

export LANG=en_US.UTF-8
export EDITOR="vi"
export GPG_TTY=$(tty)
export AWS_VAULT_BACKEND=file

export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f -i'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::git
zinit snippet PZTM::history
zinit snippet PZTM::ssh
zinit snippet PZTM::gpg
zinit light Aloxaf/fzf-tab

### End of Zinit's installer chunk

source $HOME/.cargo/env
