# .files

Personal dotfiles for a minimal and highly customized Linux setup, built around [Hyprland](https://github.com/hyprwm/Hyprland), Wayland-native tools, and the **Kanagawa** colorscheme.  
This rice tries to focus a lot on minimalism, performance and efficiency as much as reasonable. I hope you like it

---

## 📸 Screenshots

![wallpaper](/Pictures/screenshots/showcase1.png)
![workflow](/Pictures/screenshots/showcase2.png)
![gaming_misc](/Pictures/screenshots/showcase3.png)

---

## 🧩 Components

These dotfiles configure the tools I use daily:

| App         | Purpose                                               |
| ----------- | ----------------------------------------------------- |
| `fastfetch` | Blazing-fast neofetch alternative                     |
| `fish`      | Friendly interactive shell with theme + plugin setup  |
| `fuzzel`    | Application launcher for wlroots (like rofi)          |
| `hypr`      | [Hyprland](https://github.com/hyprwm/Hyprland) config |
| `kitty`     | GPU-accelerated terminal emulator                     |
| `nvim`      | Full-featured Neovim setup (IDE-lite)                 |
| `scripts`   | Custom helper scripts (runners, toggles, etc.)        |
| `dunst`     | Wayland-compatible notification center                |
| `waybar`    | Custom Wayland status bar with modules and styling    |

---

## ⚙️ Installation

All my dotfiles are managed through [chezmoi](https://www.chezmoi.io/).

Install chemzoi through your package manager (recommended) and then use it like this:

```bash
chezmoi init --apply kaezrr
```

For transitory environments:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot kaezrr
```
