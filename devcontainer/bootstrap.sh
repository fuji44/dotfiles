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

# Install tools via mise
echo "📦 Installing tools defined in .mise.toml..."
"$MISE_BIN" install

# 既存の install.sh を実行 (シンボリックリンクの作成)
echo "🔗 Creating symlinks..."
bash "$(dirname "$0")/../install.sh"

echo "✨ Personal environment is ready!"
