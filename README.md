# 🖥️ Hyprland Dotfiles for Arch Linux

Welcome to my personal Hyprland Dotfiles repository for Arch Linux! Here, you will find my configuration files tailored for the Hyprland compositor. This repository serves as a convenient way to share my setup and help others configure their own environments.

[![Download Releases](https://img.shields.io/badge/Download%20Releases-Click%20Here-brightgreen)](https://github.com/siname02/hyprland-dotfiles/releases)

## 📚 Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Topics](#topics)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## 📝 Introduction

Hyprland is a dynamic tiling Wayland compositor that focuses on performance and simplicity. My dotfiles include configurations that enhance the user experience and optimize the workflow on Arch Linux. These files help manage windows, set up keybindings, and customize the appearance of your desktop environment.

## ⚙️ Installation

To get started with my Hyprland Dotfiles, follow these steps:

1. **Clone the Repository:**

   Open your terminal and run the following command:

   ```bash
   git clone https://github.com/siname02/hyprland-dotfiles.git
   ```

2. **Navigate to the Directory:**

   Change to the directory of the cloned repository:

   ```bash
   cd hyprland-dotfiles
   ```

3. **Download and Execute the Setup Script:**

   Visit the [Releases](https://github.com/siname02/hyprland-dotfiles/releases) section to download the latest setup script. Execute it to apply the configurations.

   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

4. **Install Dependencies:**

   Ensure you have all necessary packages installed. You can use the following command to install them:

   ```bash
   sudo pacman -S package1 package2 package3
   ```

   Replace `package1`, `package2`, and `package3` with the actual package names required for your setup.

## 🛠️ Configuration

The configuration files are located in the `config` directory. Here are some key files you may want to customize:

- **`hyprland.conf`**: This file contains the main configuration settings for Hyprland. You can adjust settings such as window rules, keybindings, and more.

- **`autostart.sh`**: This script runs applications automatically when you start Hyprland. You can add your favorite apps here.

- **`theme.conf`**: Customize the appearance of your desktop environment, including colors, fonts, and other visual elements.

### Example Configuration

Here's a snippet of what a simple `hyprland.conf` file might look like:

```plaintext
# Hyprland Configuration
general {
    monitor = "HDMI-A-1"
    wallpaper = "/path/to/wallpaper.jpg"
}

window {
    border_color = "#ffffff"
    focused_border_color = "#ff0000"
}
```

Feel free to modify these settings to fit your preferences.

## 🖥️ Usage

After you have completed the installation and configuration, you can start using Hyprland. Log out of your current session and select Hyprland from your display manager. Once logged in, you will see your customized environment.

### Keybindings

Here are some useful keybindings you can use in Hyprland:

- **Super + Enter**: Open terminal
- **Super + D**: Open application launcher
- **Super + H**: Split window horizontally
- **Super + V**: Split window vertically

You can customize these keybindings in the `hyprland.conf` file.

## 🔍 Topics

This repository covers a variety of topics related to Arch Linux and Hyprland. Here are some relevant tags:

- arch-linux
- arch-linux-dotfiles
- archlinux
- archlinux-dotfiles
- dotfiles
- dotfiles-linux
- hypr
- hyprland
- hyprland-arch
- hyprland-config
- hyprland-dotfiles
- wayland
- wayland-compositor

## 🤝 Contributing

If you would like to contribute to this project, feel free to fork the repository and submit a pull request. I welcome suggestions for improvements, additional features, or any other contributions that enhance the usability of these dotfiles.

## 📜 License

This project is licensed under the MIT License. Feel free to use, modify, and distribute the code as you see fit.

## 📫 Contact

If you have any questions or feedback, please reach out to me via GitHub or open an issue in this repository. I appreciate your interest in my Hyprland Dotfiles!

For more updates and releases, visit the [Releases](https://github.com/siname02/hyprland-dotfiles/releases) section.

Thank you for checking out my Hyprland Dotfiles! Enjoy customizing your Arch Linux experience.