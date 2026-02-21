#!/usr/bin/env bash
set -eu

# Install sheldon
if ! command -v sheldon &> /dev/null; then
    echo "🚀 Installing Sheldon for my personal use..."
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi

# 2. 既存の install.sh を実行 (シンボリックリンクの作成)
echo "🔗 Creating symlinks..."
bash "$(dirname "$0")/../install.sh"

echo "✨ Personal environment is ready!"
