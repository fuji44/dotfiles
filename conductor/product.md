# Initial Concept
個人の設定ファイル（dotfiles）をセットアップします。

# Product Definition

## Project Vision: Simplicity First
fuji44氏の個人作業環境を最適化し、最小限のスクリプト管理とシンプルな構成で、迷いのない一貫した開発体験を提供します。

## Core Goals
- **Personal Optimization**: fuji44氏の好みに特化し、特定のツール（Sheldon, Starship）を最大限に活用する。
- **Automated Workflow**: install.sh および uninstall.sh による、一貫性のある自動セットアップと安全なクリーンアップを実現する。
- **Development-Ready**: DevContainer や各種ランタイム（Node.js, Deno）の設定をあらかじめ最適化しておく。

## Key Features
- **Modern Zsh Setup**: Sheldon によるプラグイン管理と Starship プロンプトを統合し、視認性と操作性の高いシェル環境を構築。
- **Environment Integration**: DevContainer の bootstrap 処理など、開発コンテナ内での利用も考慮した設計。
- **Symlink Management**: 必要な設定ファイルをホームディレクトリへ迅速にシンボリックリンクとして配置。

## Success Metrics
- 新しい環境において install.sh を実行するだけで、すぐに望みのシェル環境が利用可能になること。
- 設定の変更が管理しやすく、不要になった際も uninstall.sh で完全に元の状態に戻せること。
