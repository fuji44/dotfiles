if [ -d "$HOME/dotfiles/zsh" ]; then
  for config_file in "$HOME/dotfiles/zsh/"*.zsh; do
    source "$config_file"
  done
fi

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
