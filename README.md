# .files

Personal dotfiles for a minimal and highly customized Linux setup, built around Niri and Noctalia Shell.

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
