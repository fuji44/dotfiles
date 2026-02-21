# fuji44's dotfiles

個人の開発環境設定（dotfiles）を管理・セットアップするためのリポジトリです。

## プロジェクト概要

このリポジトリは、以下の設定を一元管理します。

- シェル設定 (Zsh, Tmux, Starship)
- Git のグローバル設定拡張
- Sheldon による Zsh プラグイン管理
- AI アシスタント向けの共通指示書 (AGENTS.md, GEMINI.md など)

## クイックスタート

### インストール

ホームディレクトリ直下にシンボリックリンクを作成し、設定を反映させます。

```bash
cd ~/dotfiles && ./install.sh
```

### アンインストール

作成したシンボリックリンクを削除し、バックアップがあれば復元します。

```bash
cd ~/dotfiles && ./uninstall.sh
```

## プロジェクト構成

```text
.
├── .editorconfig          # エディタ設定
├── .gitconfig             # Git設定の拡張
├── .gitignore_global      # グローバルなgitignoreパターン
├── .tmux.conf             # Tmuxの設定
├── .zshrc                 # メインのZsh設定
├── install.sh             # インストールスクリプト
├── uninstall.sh           # アンインストールスクリプト
├── starship.toml          # Starshipプロンプト設定
├── AGENTS.md              # AIエージェント向け作業ガイドライン
├── sheldon/
│   └── plugins.toml       # Sheldonプラグイン定義
├── zsh/
│   ├── 00_basic.zsh       # Zsh基本設定
│   ├── 20_node.zsh        # Node.js関連
│   ├── 20_deno.zsh        # Deno関連
│   ├── 90_aliases.zsh     # エイリアス
│   └── 99_starship.zsh    # Starship初期化
├── devcontainer/
│   └── bootstrap.sh       # コンテナセットアップ
├── ai/
│   └── common_instructions.md # 全プロジェクト共通のAI指示書
└── conductor/             # 内部ドキュメント・ワークフロー
```

## 開発環境

### DevContainer

VS Code などの DevContainer 機能を使い、分離された環境で設定のテストが可能です。

```bash
devcontainer up --workspace-folder .
./devcontainer/bootstrap.sh
```

### AI 設定の管理

`ai/common_instructions.md` を編集することで、全ての AI アシスタント（AGENTS.md, GEMINI.md, CLAUDE.md 等）に対する共通の指示を一括で更新できます。
