# basic
alias ll="ls -lha --color=auto"
alias grep="grep --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# git
function gw() {
  if [ -z "$1" ]; then
    echo "❌ エラー: ブランチ名を指定してください"
    echo "💡 使い方: gw <branch-name> [base-branch]"
    return 1
  fi

  local branch_name="$1"
  local base_branch="${2:-HEAD}"
  local target_dir="../$branch_name"

  echo "🌿 新しいWorktreeを作成します: $target_dir (派生元: $base_branch)"

  # Worktreeを作成してブランチを切る
  git worktree add -b "$branch_name" "$target_dir" "$base_branch"

  # 作成したディレクトリに移動
  cd "$target_dir" || return

  echo "✅ 移動しました: $(pwd)"
}

function gw-rm() {
    local current_dir=$(basename "$PWD")
    cd ..
    git worktree remove "$current_dir"
    git branch -D "$current_dir" # ブランチも同時に消す場合
    echo "🗑️ Worktree $current_dir を削除しました"
}


# claude code
if command -v npx >/dev/null 2>&1; then
  alias claude="npx @anthropic-ai/claude-code"
fi

# gemini cli
if command -v npx >/dev/null 2>&1; then
  alias gemini="npx @google/gemini-cli"
fi

# opencode
if command -v npx >/dev/null 2>&1; then
  alias gemini="npx opencode-ai@latest"
fi
