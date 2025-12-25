HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt correct
setopt autocd

bindkey "^[[1;5A" history-beginning-search-backward

autoload -Uz compinit && compinit

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle :omz:plugins:ssh-agent quiet yes

plugins=(
  git
  git-extras
  zsh-vi-mode
  extract
  sudo
  z
  cp
  docker
  docker-compose
  ssh-agent
  zsh-autosuggestions
  zsh-syntax-highlighting
)

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZSH/oh-my-zsh.sh

alias ll='eza -lh --git --icons'
alias la='eza -lha --git --icons'
alias lt='eza -T --level=3 --icons --git-ignore'
alias ls='eza --icons'
alias v='nvim'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/enot/.dart-cli-completion/zsh-config.zsh ]] && . /home/enot/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

