#!/usr/bin/env bash
set -eu

# Install mise
if ! command -v mise &> /dev/null; then
  echo "🚀 Installing mise..."
  curl https://mise.run | sh
fi

# Install tools via mise
echo "📦 Installing tools defined in .mise.toml..."
~/.local/bin/mise install

# 既存の install.sh を実行 (シンボリックリンクの作成)
echo "🔗 Creating symlinks..."
bash "$(dirname "$0")/../install.sh"

echo "✨ Personal environment is ready!"
