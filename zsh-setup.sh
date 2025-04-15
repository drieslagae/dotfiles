#!/bin/bash

set -e

# Install Zsh if it's not already installed
if ! command -v zsh &> /dev/null; then
  echo "Installing zsh..."
  apt-get update && apt-get install -y zsh curl git
fi

# Install oh-my-zsh if not already present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install zsh plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

# Update .zshrc to include plugins and theme
echo "Configuring .zshrc..."
cat <<EOF > "$HOME/.zshrc"
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source \$ZSH/oh-my-zsh.sh
EOF

# Set zsh as default shell
echo "Changing shell to zsh..."
chsh -s $(which zsh)

echo "✅ zsh and oh-my-zsh installed with plugins and agnoster theme!"
