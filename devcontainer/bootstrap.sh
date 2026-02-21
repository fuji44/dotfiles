#!/usr/bin/env bash
set -eu

# Install sheldon
if ! command -v sheldon &> /dev/null; then
    echo "🚀 Installing Sheldon for my personal use..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # パスを一時的に通して直後の実行を可能にする
    export PATH="$HOME/.local/bin:$PATH"
    # sheldon のインストール (cargo等を使用するかバイナリを落とす)
    # ここでは例としてバイナリを直接取得する公式スクリプトを想定
    curl --proto '=https' --tlsv1.2 -sSf https://sheldon.cli.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin"
fi

# 2. 既存の install.sh を実行 (シンボリックリンクの作成)
echo "🔗 Creating symlinks..."
bash "$(dirname "$0")/../install.sh"

echo "✨ Personal environment is ready!"
