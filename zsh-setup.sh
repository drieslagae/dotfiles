#!/bin/bash

set -e

echo "🔧 Setting up zsh and oh-my-zsh..."

# Install zsh if it's not installed
if ! command -v zsh &> /dev/null; then
  echo "📦 Installing zsh..."
  apt-get update && apt-get install -y zsh curl git locales
fi

# Set up UTF-8 locale (some containers don't have this)
echo "🌐 Setting up locale..."
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Installing oh-my-zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Plugins directory
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "🔌 Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "🔌 Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Create .zshrc
echo "📝 Writing .zshrc..."
cat <<EOF > "$HOME/.zshrc"
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source \$ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

PROMPT='%n@%m:%~ %# '
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
EOF

# Change default shell to zsh
echo "🌀 Setting zsh as default shell..."
chsh -s $(which zsh)

echo "✅ zsh & oh-my-zsh setup complete!"
