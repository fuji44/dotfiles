#!/usr/bin/env bash
set -eu

# Detect or install mise
if command -v mise &> /dev/null; then
  MISE_BIN="$(command -v mise)"
elif [ -x "$HOME/.local/bin/mise" ]; then
  MISE_BIN="$HOME/.local/bin/mise"
elif [ -x "$HOME/.cargo/bin/mise" ]; then
  MISE_BIN="$HOME/.cargo/bin/mise"
else
  echo "🚀 mise をインストールしています..."
  curl https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
  MISE_BIN="$HOME/.local/bin/mise"
fi

# シンボリックリンクの作成（~/.config/mise/config.toml を先に配置する）
echo "🔗 シンボリックリンクを作成しています..."
bash "$(dirname "$0")/../install.sh"

# mise でツールをインストール（グローバル設定は自動的に信頼される）
echo "📦 mise でツールをインストールしています..."
"$MISE_BIN" install -y

# Sheldon プラグインのロックファイルを生成
if command -v sheldon >/dev/null 2>&1; then
  echo "📦 Sheldon のロックファイルを更新しています..."
  sheldon lock
fi

echo "✨ 個人環境のセットアップが完了しました!"

