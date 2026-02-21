if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

if command -v deno >/dev/null 2>&1; then
  source <(deno completions zsh)
fi
