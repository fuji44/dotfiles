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
  echo "🚀 Installing mise..."
  curl https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
  MISE_BIN="$HOME/.local/bin/mise"
fi

# Trust .mise.toml and install tools
echo "📦 Installing tools defined in .mise.toml..."
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
"$MISE_BIN" trust "$DOTFILES_DIR/.mise.toml"
"$MISE_BIN" install -y

# 既存の install.sh を実行 (シンボリックリンクの作成)
echo "🔗 Creating symlinks..."
bash "$(dirname "$0")/../install.sh"

echo "✨ Personal environment is ready!"
