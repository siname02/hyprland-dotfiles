# Python Virtual Environment
# Define the token and register it with grml
function virtual_env_prompt() {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}
grml_theme_add_token virtual-env -f virtual_env_prompt '%F{magenta}' '%f'

# Make the prompt use the token
zstyle ':prompt:grml:left:setup' items rc change-root user at host path virtual-env vcs percent
zstyle ':prompt:grml:right:setup' items date time

# Source
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/nvm/init-nvm.sh

# Export
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.local/bin
export EDITOR="vim"
export VCPKG_ROOT=$HOME/.local/share/vcpkg

alias vscode='code --enable-features=UseOzonePlatform --ozone-platform=wayland'

neofetch
