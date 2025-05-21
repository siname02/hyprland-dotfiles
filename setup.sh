#!/bin/bash

set -euo pipefail

echo "========================================"
echo "  🌌 Hyprland Setup Script"
echo "  Author: @sumithemmadi <Sumith Emmadi>"
echo "  Email: sumithemmadi244@gmail.com"
echo "  GitHub: https://github.com/sumithemmadi"
echo "  Version: 1.0"
echo "========================================"

echo "🚀 Starting setup..."

# === Utility Functions ===
log() { echo -e "🔧 $1"; }
warn() { echo -e "⚠️  $1"; }
success() { echo -e "✅ $1"; }

install_if_missing() {
    local cmd="$1"
    local aur_repo="$2"
    if ! command -v "$cmd" &>/dev/null; then
        log "$cmd not found. Installing $aur_repo from AUR..."
        local tmp
        tmp=$(mktemp -d)
        git clone "https://aur.archlinux.org/$aur_repo.git" "$tmp"
        pushd "$tmp" >/dev/null
        makepkg -si --noconfirm
        popd >/dev/null
        rm -rf "$tmp"
    else
        success "$cmd is already installed."
    fi
}

# === Step 1: Install paru if missing ===
install_if_missing "paru" "paru-bin"

# === Step 2: Install all required packages ===
log "Installing packages with paru..."
paru -S --needed --noconfirm \
    git vim vim-plug code-minimap-bin zsh grml-zsh-config less tree nautilus networkmanager \
    zsh-autosuggestions zsh-syntax-highlighting neofetch brightnessctl pavucontrol bluez-utils \
    hyprland hyprpaper waybar swaybg hyprpicker hyprshot socat clipman \
    extra/pipewire extra/pipewire-alsa extra/pipewire-jack \
    extra/pipewire-pulse extra/wireplumber \
    multilib/lib32-pipewire multilib/lib32-pipewire-jack \
    ttf-nerd-fonts-symbols-mono \
    ttf-ubuntu-font-family ttf-fira-code ttf-hack \
    ttf-jetbrains-mono ttf-dejavu noto-fonts noto-fonts-cjk \
    noto-fonts-emoji noto-fonts-extra ttf-fira-mono \
    ttf-fira-sans ttf-firacode-nerd \
    nodejs npm yarn nvm php python python-pip python-pipx jdk-openjdk maven \
    kitty visual-studio-code-bin firefox brave-bin

# === Step 3: Setup directory paths ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
CONFIG_DIR="$DOTFILES_DIR/config"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"
WALLPAPER_SRC="$SCRIPT_DIR/shared/wallpapers"
WALLPAPER_DEST="$HOME/.local/share/wallpapers"

# === Step 4: Copy dotfiles ===
log "Copying dotfiles..."
for file in .gitconfig .vimrc .zshrc; do
    src="$DOTFILES_DIR/$file"
    [[ -f "$src" ]] && cp "$src" "$HOME/" && echo "✓ $file copied" || warn "$file not found."
done

# === Step 5: Sync configs ===
log "Syncing config folders..."
mkdir -p "$HOME/.config"
if [[ -d "$CONFIG_DIR" ]]; then
    for dir in "$CONFIG_DIR"/*; do
        [[ -d "$dir" ]] || continue
        dest="$HOME/.config/$(basename "$dir")"
        rm -rf "$dest"
        cp -r "$dir" "$dest"
        echo "✓ Synced $(basename "$dir")"
    done
else
    warn "$CONFIG_DIR does not exist."
fi

# === Step 6: Copy scripts ===
log "Copying scripts..."
rm -rf "$HOME/.scripts"
cp -r "$SCRIPTS_DIR" "$HOME/.scripts"

# === Step 7: Copy wallpapers ===
log "Copying wallpapers..."
rm -rf "$WALLPAPER_DEST"
mkdir -p "$WALLPAPER_DEST"
cp -r "$WALLPAPER_SRC"/* "$WALLPAPER_DEST"

# === Step 8: Refresh Hyprland ===
log "Reloading Hyprland..."
if command -v hyprctl &>/dev/null; then
    hyprctl reload
else
    warn "Hyprland not found. Skipping."
fi

# === Step 9: Set default shell to Zsh ===
log "Setting default shell to Zsh..."
ZSH_PATH="$(which zsh)"
if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "$ZSH_PATH" || warn "Failed to change default shell."
[[ "$SHELL" != "$ZSH_PATH" ]] && warn "Please log out and back in to apply shell change." || success "Zsh is now default."

# === Step 10: Install Vim plugins ===
log "Installing Vim plugins..."
if command -v vim &>/dev/null; then
    vim +PlugInstall +qall || warn "Failed to install Vim plugins."
else
    warn "Vim not found. Skipping plugin installation."
fi

# === Step 11: setup git ===
log "Setting up git..."
# Ask to set up Git
read -p "Do you want to set up Git? (y/n): " setup_git

if [[ "$setup_git" == "y" || "$setup_git" == "Y" ]]; then

    # Ask for Git username (no validation)
    while true; do
        read -p "Enter your Git username: " git_username
        if [[ -n "$git_username" ]]; then
            break
        else
            echo "❌ Username cannot be empty. Please try again."
        fi
    done

    # Ask for Git email (no validation)
    while true; do
        read -p "Enter your Git email: " git_email
        if [[ -n "$git_email" ]]; then
            break
        else
            echo "❌ Email cannot be empty. Please try again."
        fi
    done

    # Ask for default branch
    read -p "Use 'main' as the default branch name? (y/n): " use_main_branch
    if [[ "$use_main_branch" == "y" || "$use_main_branch" == "Y" ]]; then
        git config --global init.defaultBranch main
        echo "✅ Default branch set to 'main'."
    fi

    # Apply Git configuration
    git config --global user.name "$git_username"
    git config --global user.email "$git_email"

    echo "✅ Git has been configured successfully:"
    echo "  Name : $(git config --global user.name)"
    echo "  Email: $(git config --global user.email)"
    echo "  Default Branch: $(git config --global init.defaultBranch 2>/dev/null || echo 'Not set')"

else
    echo "❎ Git setup skipped."
fi

# === Done ===
success "Setup complete."
