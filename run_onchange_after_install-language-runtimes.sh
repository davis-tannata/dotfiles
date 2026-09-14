#!/usr/bin/env bash

# Install the Node / Flutter / Java versions used across machines.
# Idempotent: already-installed versions are skipped. Edit a list and re-apply
# (chezmoi re-runs this because it's run_onchange) to add a new version.

# ---------- Node (nvm) ----------
NODE_VERSIONS="18.20.4 20.20.0 22.22.2"
NODE_DEFAULT="20"
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "==> Node (nvm)"
  . "$NVM_DIR/nvm.sh"
  for v in $NODE_VERSIONS; do nvm install "$v" >/dev/null 2>&1 && echo "  node $v"; done
  nvm alias default "$NODE_DEFAULT" >/dev/null 2>&1
else
  echo "==> nvm not found; skipping Node"
fi

# ---------- Flutter (fvm) ----------
FLUTTER_VERSIONS="3.24.3"
FLUTTER_GLOBAL="3.24.3"
if command -v fvm >/dev/null 2>&1; then
  echo "==> Flutter (fvm)"
  for v in $FLUTTER_VERSIONS; do fvm install "$v" >/dev/null 2>&1 && echo "  flutter $v"; done
  fvm global "$FLUTTER_GLOBAL" >/dev/null 2>&1
else
  echo "==> fvm not found; skipping Flutter"
fi

echo "==> language runtimes ready"


# -- coc nvim
echo "==> Installing/Updating coc.nvim extensions..."

if [ -d "$HOME/.config/coc/extensions" ]; then
    (
        cd "$HOME/.config/coc/extensions" &&
        npm install --no-audit --no-fund --quiet
    )
fi

