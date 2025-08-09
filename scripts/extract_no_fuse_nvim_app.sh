#!/bin/bash

# If nvim command is not found, exit with an error message
if ! command -v nvim >/dev/null 2>&1; then
    echo "[ERROR] Neovim is not installed. Please install Neovim first."
    exit 1
fi

mkdir -pv ~/.local/opt ~/.local/bin
cd ~/.local/opt && nvim --appimage-extract
ln -sfv ~/.local/opt/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
echo "[INFO] Installed Neovim for non-FUSE environments."
