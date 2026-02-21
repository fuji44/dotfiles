HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# 履歴の重複を無視
setopt hist_ignore_dups
# 履歴を即座に共有
setopt share_history
# ディレクトリ名だけで cd
setopt auto_cd
