#!/usr/bin/env bash
set -eu

targets=(
  ".zshrc"
  ".tmux.conf"
  ".gitignore_global"
)

echo "🗑️  Removing dotfiles setup..."

echo "📂 Removing symlinks..."
for target in "${targets[@]}"; do
  path="$HOME/$target"
  if [ -L "$path" ]; then
    rm "$path"
    echo "  - Removed link: $target"
  elif [ -f "$path" ]; then
    echo "  ! Skipped: $path (Not a symlink)"
  fi
done

echo "⚙️  Reverting Git configuration..."
if git config --global --get include.path "$HOME/dotfiles/.gitconfig" > /dev/null; then
  git config --global --unset include.path "$HOME/dotfiles/.gitconfig"
  echo "  - Removed include.path from .gitconfig"
else
  echo "  ! No include.path found in .gitconfig"
fi

echo "✅ Uninstallation complete!"
echo "💡 Note: Please restore any backup files in $HOME manually if needed."
