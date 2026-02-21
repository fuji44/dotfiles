# Product Guidelines

## Communication Style: Concise & Technical
- **Documentation**: ドキュメントや README は簡潔に、要点のみを技術的に記述します。
- **Comments**: コード内のコメントは、その箇所の「なぜ（Why）」に焦点を当て、冗長な説明は避けます。
- **Commit Messages**: 変更内容を明確かつ端的に示し、履歴を追いやすく保ちます。

## UX & Design Principles
- **Performance First**: シェルの起動速度やコマンド実行のレスポンスを最優先事項とします。プラグインの遅延読み込みなどを積極的に活用します。
- **Visual Clarity**: Starship や適切な色分けを駆使し、カレントディレクトリ、Git ステータス、ランタイム情報などを一目で把握できるようにします。
- **Safe & Non-intrusive**: 既存のシステム設定を破壊せず、`install.sh`/`uninstall.sh` を通じて安全に導入・削除できる非侵入的な設計を維持します。

## File & Configuration Organization
- **Granular & Modular**: 設定は Zsh, Sheldon, Starship など機能やツールごとに細かく分割し、役割を明確にします。
- **Maintainability**: ファイル分割により、特定の設定変更が他の部分に影響を与えないようにし、メンテナンス性を高めます。
- **Naming Conventions**: ファイル名は `00_basic.zsh`, `20_node.zsh` のように、読み込み順序や役割が直感的にわかる命名を採用します。
