# Specification: シェルスクリプト（install.sh/uninstall.sh）の堅牢化とドキュメント整備

## 1. Overview
本トラックの目的は、`install.sh` および `uninstall.sh` の信頼性とメンテナンス性を向上させることです。現在のスクリプトにエラーハンドリングを追加し、べき等性（何度も実行しても同じ結果になること）を確保し、スタイルガイドに準拠させます。

## 2. Goals
- **Error Handling**: 失敗時に適切に終了し、ユーザーに原因を伝える。
- **Idempotency**: 既にシンボリックリンクが存在する場合などの処理を適切に行う。
- **Readability**: スタイルガイド（general.md）に準拠した記述。
- **Documentation**: 各関数の役割や変数の意味をコメントで明文化する。

## 3. Requirements
- `set -euo pipefail` などの安全な Bash 設定の導入。
- シンボリックリンク作成時の既存ファイルチェックとバックアップ機能の検討。
- ログ出力の統一（情報、警告、エラーの区別）。
- Deno, Node, Sheldon 等の外部依存ツールが未インストールの際のアラート。

## 4. Non-Functional Requirements
- **Safety**: 既存の設定ファイルを不用意に上書き・削除しない。
- **Cleanliness**: アンインストール時に、インストール前と同じ状態に可能な限り戻す。
