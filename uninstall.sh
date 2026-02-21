#!/usr/bin/env bash
set -eu

DOTFILES_DIR="$HOME/dotfiles"

# 引数1: ホームディレクトリからの展開先パス
unlink_file() {
  local dst="$HOME/$1"

  # シンボリックリンクであれば削除
  if [ -L "$dst" ]; then
    rm "$dst"
    echo "🗑️  Unlinked: $1"

    # バックアップがあれば復元 (最新の1つ)
    local backup=$(ls -1 "${dst}.bak_"* 2>/dev/null | sort -r | head -n 1)
    if [ -n "$backup" ]; then
      mv "$backup" "$dst"
      echo "🔄 Restored backup for $1 from ${backup##*/}"
    fi

    # もし親ディレクトリが空になったら削除 (オプション)
    local parent=$(dirname "$dst")
    if [ "$parent" != "$HOME" ] && [ -d "$parent" ] && [ ! "$(ls -A "$parent")" ]; then
      rmdir "$parent"
      echo "📁 Removed empty directory: ${parent#$HOME/}"
    fi
  fi
}

echo "🧹 Starting dotfiles uninstallation..."

# --- リンク解除の定義 (install.shと対にする) ---
unlink_file ".zshrc"
unlink_file ".tmux.conf"
unlink_file ".gitignore_global"
unlink_file ".config/starship.toml"
unlink_file ".config/sheldon/plugins.toml"

# --- Git構成の解除 ---
echo "⚙️ Reverting Git config..."
git config --global --unset include.path "$DOTFILES_DIR/.gitconfig"

# --- AI Assistant instructions (Global) Cleanup ---
AI_TARGET_FILES=(".config/opencode/AGENTS.md" ".gemini/GEMINI.md" ".claude/CLAUDE.md")
echo "🤖 Cleaning up global AI assistant instructions..."
for target in "${AI_TARGET_FILES[@]}"; do
  unlink_file "$target"
done

echo "✅ Uninstallation complete!"
echo "💡 Note: Backup files (.bak_*) were kept. Restore them manually if needed."
