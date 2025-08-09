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
- If you want to install nvim app only, please execute the following command:
  ```bash
  ./nvim/install.sh --app-only
  ```
  - If your environment does not have `FUSE`, please execute the following command additionally:
    ```bash
    ./nvim/install.sh --no-fuse-nvim-app
    ```

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
