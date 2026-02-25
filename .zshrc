if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
elif [ -d "$HOME/dotfiles/zsh" ]; then
  echo "⚠️ Sheldon not found. Loading scripts manually..."
  for config_file in "$HOME/dotfiles/zsh/"*.zsh; do
    source "$config_file"
  done
fi

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
