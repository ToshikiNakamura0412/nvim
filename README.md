# nvim

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Environment
### OS
- Linux
  - alpine
  - arch
  - debian
  - fedora
  - opensuse (leap)
  - ubuntu
- macOS (Prerequisites: pip3)

### Architecture
- x86_64
- arm64

## Installation
```bash
git clone --recursive https://github.com/ToshikiNakamura0412/nvim.git
./nvim/install.sh
```
### Options
- `--setup-only` : If you want to run only the setup script without installing the prerequisites, use this option.
- `--app-only` : If you want to install the nvim app only, use this option.
  - `--no-fuse-nvim-app` : If your environment does not have `FUSE`, execute additional installation with this option.

## Setup
### plugin
- Please set executable.command path for `jedi-language-server`
  ```bash
  nvim ~/.config/nvim/coc-settings.json
  ```
- If you want to enable Github Copilot, please execute the following in Neovim:
  ```
  :Copilot setup
  ```
