#!/usr/bin/env bash
set -eu

DOTFILES_DIR="$HOME/dotfiles"

# 引数1: リポジトリ内の相対パス
# 引数2: ホームディレクトリからの展開先パス
link_file() {
  local src="$DOTFILES_DIR/$1"
  local dst="$HOME/$2"

  # 展開先の親ディレクトリを作成
  mkdir -p "$(dirname "$dst")"

  # 既に正しいリンクが貼られている場合はスキップ
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return
  fi

  # 実体ファイルがある場合はバックアップ
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    local backup="${dst}.bak_$(date +%Y%m%d_%H%M%S)"
    mv "$dst" "$backup"
    echo "📦 バックアップ: $dst → $backup"
  fi

  ln -sf "$src" "$dst"
  echo "🔗 リンク作成: $2 → $1"
}

echo "🔗 dotfiles のインストールを開始します..."

# --- リンク設定の定義 ---
link_file ".zshrc" ".zshrc"
link_file ".tmux.conf" ".tmux.conf"
link_file ".gitignore_global" ".gitignore_global"
link_file ".config/starship.toml" ".config/starship.toml"
link_file ".config/sheldon/plugins.toml" ".config/sheldon/plugins.toml"
link_file ".config/mise/config.toml" ".config/mise/config.toml"

# --- Git構成の統合 ---
# ホストOS(Windows)のghコマンド認証を維持するため上書きせずincludeする
echo "⚙️ Git を設定しています..."
git config --global include.path "$DOTFILES_DIR/.gitconfig"

# --- AI Assistant instructions (Global) ---
# 全プロジェクト共通で使う指示書をホームディレクトリ直下に展開する
AI_INSTRUCTIONS_SRC="ai/common_instructions.md"
AI_TARGET_FILES=(".config/opencode/AGENTS.md" ".gemini/GEMINI.md" ".claude/CLAUDE.md")

echo "🤖 AI アシスタントの共通設定をリンクしています..."
for target in "${AI_TARGET_FILES[@]}"; do
  link_file "$AI_INSTRUCTIONS_SRC" "$target"
done

echo "✅ インストール完了!"
echo "💡 sheldon プラグインを更新した場合は 'sheldon lock' を実行してください。"
