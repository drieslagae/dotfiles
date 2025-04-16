#!/bin/bash
set -e

echo "🛠 Installing required packages..."
apt-get update && apt-get install -y zsh curl git locales procps

echo "🌐 Configuring locale..."
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo "💡 Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || true

echo "📝 Creating .zshrc..."
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

chsh -s $(which zsh)

echo "✅ Done! Run 'zsh' to enter your new shell 🎉"
