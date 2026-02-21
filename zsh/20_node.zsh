# Node manager
export VOLTA_HOME="$HOME/.volta"

# volta
if [ -d "$VOLTA_HOME/bin" ] || command -v volta >/dev/null 2>&1; then
  case ":$PATH:" in
    *":$VOLTA_HOME/bin:"*) ;;
    *) export PATH="$VOLTA_HOME/bin:$PATH" ;;
  esac
# nvm
elif [ -d "$HOME/.nvm" ] || [ -d "/usr/local/share/nvm" ]; then
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  if [ -d "/usr/local/share/nvm" ]; then
    export NVM_DIR="/usr/local/share/nvm"
  fi

  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
fi

# Global configs
NPM_GLOBAL_DIR="$HOME/.npm-global"
if [ -d "$NPM_GLOBAL_DIR" ]; then
  export PATH="$NPM_GLOBAL_DIR/bin:$PATH"
fi

# npm
# if command -v npm >/dev/null 2>&1; then
#   alias ni="npm install"
#   alias nD="npm install -D"
#   alias nr="npm run"
#   alias ns="npm start"
#   alias nt="npm test"
# fi

# pnpm
if command -v pnpm >/dev/null 2>&1; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
