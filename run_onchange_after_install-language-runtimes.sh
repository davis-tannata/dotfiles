#!/bin/sh
# Install the Node / Flutter / Java versions used across machines.
# Idempotent: already-installed versions are skipped. Edit a list and re-apply
# (chezmoi re-runs this because it's run_onchange) to add a new version.

# ---------- Node (nvm) ----------
NODE_VERSIONS="16.20.2 18.20.4 20.18.0 20.20.0 22.22.2"
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
FLUTTER_VERSIONS="3.24.3 3.19.6"
FLUTTER_GLOBAL="3.24.3"
if command -v fvm >/dev/null 2>&1; then
  echo "==> Flutter (fvm)"
  for v in $FLUTTER_VERSIONS; do fvm install "$v" >/dev/null 2>&1 && echo "  flutter $v"; done
  fvm global "$FLUTTER_GLOBAL" >/dev/null 2>&1
else
  echo "==> fvm not found; skipping Flutter"
fi

# ---------- Java (sdkman) ----------
JAVA_DEFAULT="17.0.16-tem"
JAVA_OTHERS="17.0.12-amzn 17.0.12-oracle"
export SDKMAN_DIR="$HOME/.sdkman"
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  echo "==> Java (sdkman)"
  . "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk install java "$JAVA_DEFAULT" >/dev/null 2>&1 && echo "  java $JAVA_DEFAULT"
  for v in $JAVA_OTHERS; do echo no | sdk install java "$v" >/dev/null 2>&1 && echo "  java $v"; done
  sdk default java "$JAVA_DEFAULT" >/dev/null 2>&1
else
  echo "==> sdkman not found; skipping Java"
fi

echo "==> language runtimes ready"
