#!/usr/bin/env bash
set -eu

DOTFILES_DIR="$HOME/dotfiles"

echo "🔗 Symlinking dotfiles..."

link_file() {
  local source="$DOTFILES_DIR/$1"
  local target="$HOME/$1"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    return
  fi

  # backup original
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "${target}.backup_$(date +%Y%m%d_%H%M%S)"
    echo "Backed up $target"
  fi

  ln -sf "$source" "$target"
  echo "Linked $1"
}

link_file ".zshrc"
link_file ".tmux.conf"
link_file ".gitignore_global"

echo "⚙️ Configuring Git to include dotfiles/.gitconfig..."
git config --global include.path "$HOME/dotfiles/.gitconfig"

echo "✅ Dotfiles setup complete!"
