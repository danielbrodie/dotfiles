#!/usr/bin/env bash
# setup.sh -- Deploy dotfiles to their expected locations
#
# Usage: bash setup.sh
#
# Backs up existing files with .bak suffix before overwriting.
# Does NOT install software -- see prerequisites below.
#
# PREREQUISITES:
#   brew bundle --file=Brewfile
#
# AFTER RUNNING:
#   1. Add fish to allowed shells and set as default:
#        echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
#        chsh -s /opt/homebrew/bin/fish
#
#   2. Install Fisher (fish plugin manager):
#        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
#
#   3. Install fish plugins:
#        fish -c "fisher install jethrokuan/z"
#        fish -c "fisher install PatrickF1/fzf.fish"
#
#   4. Install TPM (tmux plugin manager):
#        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#
#   5. Open tmux and press prefix + I to install tmux plugins
#
#   6. Restart your terminal

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

backup_and_copy() {
    local src="$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [[ -f "$dst" ]]; then
        echo "  [backup] $dst -> ${dst}.bak"
        cp "$dst" "${dst}.bak"
    fi

    cp "$src" "$dst"
    echo "  [copied] $dst"
}

echo "Deploying dotfiles..."
echo ""

backup_and_copy "$SCRIPT_DIR/git/.gitconfig"           "$HOME/.gitconfig"
backup_and_copy "$SCRIPT_DIR/ghostty/config"          "$HOME/.config/ghostty/config"
backup_and_copy "$SCRIPT_DIR/fish/config.fish"         "$HOME/.config/fish/config.fish"
backup_and_copy "$SCRIPT_DIR/fish/functions/mkcd.fish" "$HOME/.config/fish/functions/mkcd.fish"
backup_and_copy "$SCRIPT_DIR/starship/starship.toml"   "$HOME/.config/starship.toml"
backup_and_copy "$SCRIPT_DIR/tmux/tmux.conf"           "$HOME/.tmux.conf"

echo ""
echo "Done. See the top of this script for post-install steps."
