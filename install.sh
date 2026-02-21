#!/usr/bin/env bash
set -eu

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Starting dotfiles setup..."

link_file() {
  local source="$DOTFILES_DIR/$1"
  local target="$HOME/$1"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    return
  fi

  # backup original
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.backup_$(date +%Y%m%d_%H%M%S)"
    mv "$target" "$backup"
    echo "  📦 Backed up: $target -> $(basename "$backup")"
  fi

  ln -sf "$source" "$target"
  echo "  🔗 Linked: $1"
}

echo "📂 Creating symlinks..."
link_file ".zshrc"
link_file ".tmux.conf"
link_file ".gitignore_global"

echo "⚙️  Configuring Git..."
git config --global include.path "$HOME/dotfiles/.gitconfig"
echo "  + Added include.path to .gitconfig"

echo "✨ Dotfiles setup complete!"
