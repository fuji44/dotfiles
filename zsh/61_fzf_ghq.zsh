if command -v ghq >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
  function cd_ghq_repository() {
    # ghq list => fzf
    local target_repo=$(ghq list | fzf --prompt="🔍 Repo > " --query="$LBUFFER")

    if [ -n "$target_repo" ]; then
      cd "$(ghq root)/$target_repo" || return
    fi

    zle accept-line
    zle reset-prompt
  }

  zle -N cd_ghq_repository

  # Ctrl+]
  bindkey '^]' cd_ghq_repository
fi
