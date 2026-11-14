# Dotfiles

Personal configuration files managed with chezmoi.

## Directory structure

- `linux/` — Linux configurations
    - Target baseline: Ubuntu 24.04 (workplace)
    - Initial snapshot: Pop!\_OS 24.04 / MATE (home)
- `macos/` — macOS configurations (to be added)
- `bootstrap/bash/` — Archived bash configurations for initial Linux setup

Linux and macOS configurations are maintained separately.

## chezmoi configuration

Clone this repository to `~/.local/share/chezmoi`.

On Linux, configure `~/.config/chezmoi/chezmoi.toml`:

```toml
sourceDir = "/home/USERNAME/.local/share/chezmoi/linux"
workingTree = "/home/USERNAME/.local/share/chezmoi"
