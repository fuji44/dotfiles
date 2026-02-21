if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info'

  if [ -f "$HOME/.fzf.zsh" ]; then
    source "$HOME/.fzf.zsh"
  elif [ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]; then
    # apt (Ubuntu/Debian)
    source "/usr/share/doc/fzf/examples/key-bindings.zsh"
    source "/usr/share/doc/fzf/examples/completion.zsh"
  elif command -v brew >/dev/null 2>&1; then
    # Homebrew (macOS/Linuxbrew)
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" 2>/dev/null
  fi
fi
