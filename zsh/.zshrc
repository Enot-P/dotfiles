export ZSH="$HOME/.oh-my-zsh"
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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
