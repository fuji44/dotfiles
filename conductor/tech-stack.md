# Technology Stack

## Core Components
- **Zsh**: メインのインタラクティブシェルとして使用。
- **Sheldon**: Rust製の高速な Zsh プラグインマネージャー。
- **Starship**: Rust製のクロスシェル・カスタマイズ可能なプロンプト。

## Setup & Environment
- **Bash (Shell Script)**: `install.sh` や `uninstall.sh` など、セットアップ自動化スクリプトに使用。
- **DevContainer**: 開発環境のコンテナ化と `bootstrap.sh` による自動構成。

## Supported Runtimes & Tools
- **Node.js**: Zsh 設定ファイル（`20_node.zsh`）を通じて環境変数を管理。
- **Deno**: Zsh 設定ファイル（`20_deno.zsh`）を通じて環境変数を管理。
