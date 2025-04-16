# Path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# A clean, reliable theme
ZSH_THEME="bira"

# Useful plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Optional: fix locale issues inside containers
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Optional: shorter prompt
PROMPT='%n@%m:%~ %# '

# Optional: history tweaks
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
