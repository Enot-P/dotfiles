#!/bin/bash

# Путь к папке с dotfiles (относительно скрипта)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Функция для создания символической ссылки
create_link() {
    local src="$1"
    local dst="$2"

    # Если dst существует и не является ссылкой — сделать резервную копию
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "Backing up $dst to $dst.bak"
        mv "$dst" "$dst.bak"
    fi

    # Создать символическую ссылку
    ln -sf "$src" "$dst"
    echo "Linked $dst → $src"
}

# Zsh
create_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
create_link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
create_link "$DOTFILES_DIR/zellij" "$HOME/.config/zellij"


echo "Dotfiles setup complete!"
