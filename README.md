# Dotfiles

Personal configuration files managed with chezmoi.

## Directory structure

- `linux/` — Linux configurations
- `macos/` — macOS configurations
- `bootstrap/bash/` — Archived bash configurations for initial Linux setup

Linux and macOS configurations are maintained separately.

## chezmoi configuration

Clone this repository to `~/.local/share/chezmoi`.

On Linux, configure `~/.config/chezmoi/chezmoi.toml`:

```toml
sourceDir = "/home/USERNAME/.local/share/chezmoi/linux"
workingTree = "/home/USERNAME/.local/share/chezmoi"
