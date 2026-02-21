# fuji44's dotfiles

個人の設定ファイル（dotfiles）をセットアップします。

## クイックスタート

### インストール

```bash
cd ~/dotfiles && ./install.sh
```

### アンインストール

```bash
cd ~/dotfiles && ./uninstall.sh
```

## 管理対象ファイル

以下のファイルが `$HOME` にシンボリックリンクとして配置されます：

- `.zshrc`
- `.tmux.conf`
- `.gitignore_global`

## プロジェクト構成

- `.editorconfig`: このプロジェクト自体の開発用設定であり、セットアップ対象（シンボリックリンク）ではありません。
- `install.sh`: セットアップ用スクリプト。
- `uninstall.sh`: アンインストール（クリーンアップ）用スクリプト。
