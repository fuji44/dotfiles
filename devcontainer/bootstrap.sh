#!/usr/bin/env bash
set -eu
set -o pipefail

# 既存の mise バイナリを検出
find_mise_bin() {
  if command -v mise >/dev/null 2>&1; then
    command -v mise
    return 0
  fi

  local candidate_paths=(
    "/usr/bin/mise"
    "/usr/local/bin/mise"
    "$HOME/.local/bin/mise"
    "$HOME/.cargo/bin/mise"
  )

  local path
  for path in "${candidate_paths[@]}"; do
    if [ -x "$path" ]; then
      echo "$path"
      return 0
    fi
  done

  return 1
}

# 実行権限に応じた sudo プレフィックスの取得
get_sudo_prefix() {
  if [ "$(id -u)" -ne 0 ] && command -v sudo >/dev/null 2>&1; then
    echo "sudo"
  fi
}

# APT 経由でのリポジトリ追加とインストール
install_mise_apt() {
  local sudo_cmd="$1"

  $sudo_cmd apt-get update -y || return 1
  $sudo_cmd apt-get install -y curl gpg || return 1
  $sudo_cmd install -dm 755 /etc/apt/keyrings || return 1

  curl -fsSL https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | $sudo_cmd tee /etc/apt/keyrings/mise-archive-keyring.gpg > /dev/null || return 1

  local arch
  arch="$(dpkg --print-architecture)"
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=${arch}] https://mise.jdx.dev/deb stable main" | $sudo_cmd tee /etc/apt/sources.list.d/mise.list > /dev/null || return 1

  $sudo_cmd apt-get update -y || return 1
  $sudo_cmd apt-get install -y mise || return 1
}

# 環境のパッケージマネージャ等を利用して mise をインストール
install_mise() {
  local sudo_cmd
  sudo_cmd="$(get_sudo_prefix)"

  # Homebrew
  if command -v brew >/dev/null 2>&1; then
    echo "🚀 Homebrew 経由で mise をインストールしています..."
    if brew install mise; then
      return 0
    fi
    echo "⚠️ Homebrew によるインストールに失敗しました。バイナリインストーラへフォールバックします。"
  fi

  # APT (Debian / Ubuntu)
  if command -v apt-get >/dev/null 2>&1; then
    echo "🚀 APT 経由で mise をインストールしています..."
    if install_mise_apt "$sudo_cmd"; then
      return 0
    fi
    echo "⚠️ APT によるインストールに失敗しました。バイナリインストーラへフォールバックします。"
  fi

  # DNF (Fedora / RHEL)
  if command -v dnf >/dev/null 2>&1; then
    echo "🚀 DNF 経由で mise をインストールしています..."
    if $sudo_cmd dnf install -y dnf-plugins-core && \
       $sudo_cmd dnf copr enable -y jdxcode/mise && \
       $sudo_cmd dnf install -y mise; then
      return 0
    fi
    echo "⚠️ DNF によるインストールに失敗しました。バイナリインストーラへフォールバックします。"
  fi

  # Pacman (Arch Linux)
  if command -v pacman >/dev/null 2>&1; then
    echo "🚀 Pacman 経由で mise をインストールしています..."
    if $sudo_cmd pacman -Sy --noconfirm mise; then
      return 0
    fi
    echo "⚠️ Pacman によるインストールに失敗しました。バイナリインストーラへフォールバックします。"
  fi

  # APK (Alpine Linux)
  if command -v apk >/dev/null 2>&1; then
    echo "🚀 APK 経由で mise をインストールしています..."
    if $sudo_cmd apk add --no-cache mise; then
      return 0
    fi
    echo "⚠️ APK によるインストールに失敗しました。バイナリインストーラへフォールバックします。"
  fi

  # スタンドアロンバイナリ (公式インストーラスクリプト)
  echo "🚀 公式インストーラで mise をインストールしています..."
  mkdir -p "$HOME/.local/bin"
  curl -fsSL https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
}

# mise の検出またはインストール
if ! MISE_BIN="$(find_mise_bin)"; then
  install_mise
  if ! MISE_BIN="$(find_mise_bin)"; then
    echo "❌ mise のインストールまたは検出に失敗しました。" >&2
    exit 1
  fi
fi

# スクリプト内で mise が実行できるように PATH に追加
MISE_DIR="$(dirname "$MISE_BIN")"
if [[ ":$PATH:" != *":$MISE_DIR:"* ]]; then
  export PATH="$MISE_DIR:$PATH"
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

