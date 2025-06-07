# .files

Personal dotfiles for a minimal and highly customizable Linux setup, optimized for [Hyprland](https://github.com/hyprwm/Hyprland) and Wayland-based environments.
<br>
![2025-05-31-210726_hyprshot](https://github.com/user-attachments/assets/e1b548ef-a126-4797-b5f1-90ad874f99d0)
## 🧩 Components

This repo contains config files for various tools I use on a daily basis:

| Folder     | Purpose                                                   |
|------------|-----------------------------------------------------------|
| `dunst`    | Lightweight and minimal notification daemon               |
| `fastfetch`| System information fetcher (blazing-fast neofetch)       |
| `fuzzel`   | Wayland application launcher (like rofi for wlroots)     |
| `hypr`     | [Hyprland](https://github.com/hyprwm/Hyprland) WM config |
| `kitty`    | GPU-based terminal emulator                              |
| `nvim`     | Neovim config (my IDE replacement)                       |
| `scripts`  | Custom scripts and helpers used throughout the system     |
| `tmux`     | Terminal multiplexer configuration                       |
| `waybar`   | Status bar for Wayland                                   |
| `zsh`      | Z shell and plugin configuration                         |

## 🚀 Features

- Hyprland as the dynamic window manager
- Consistent visual theme across apps
- Modular structure for easy edits and updates
- Custom scripts for automation and quality-of-life tweaks
- Terminal-centric workflow with `kitty`, `zsh`, and `tmux`
- Lightweight notification and launcher tools suited for Wayland

## 📦 Setup Instructions

> ⚠️ These configs are tailored for my environment (CachyOS + Hyprland). YMMV if you're using another distro or DE.

1. Clone the repo:
```bash
git clone https://github.com/kaezrr/dotfiles.git
cd dotfiles
```

2. Symlink the folders or copy them to your home directory. I recommend using stow or a dotfile manager of your choice.

Example with stow:

```bash
stow nvim zsh tmux kitty hypr waybar dunst fuzzel
```

3. Make sure all dependencies are installed (Hyprland, kitty, dunst, etc.).
