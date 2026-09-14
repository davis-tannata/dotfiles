#!/bin/bash

set -e

echo "Installing NVM (v0.40.7)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.7/install.sh | bash

echo "Installing SDKMAN..."
curl -s "https://get.sdkman.io" | bash

echo ""
echo "✅ NVM and SDKMAN installed!"
echo ""
echo "Next steps:"
echo "1. Reload shell: source ~/.bashrc  (or ~/.zshrc)"
echo "2. Install Node: nvm install 18 && nvm install 20"
echo "3. Install Java: sdk install java 21.0.1-oracle"
