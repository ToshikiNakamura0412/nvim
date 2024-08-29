#!/bin/bash

# Prerequisites
pip3 install pynvim jedi

# Neovim
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-macos-arm64.tar.gz
tar xzf nvim-macos-arm64.tar.gz
if [ -d /opt/nvim-macos-arm64 ]; then
  sudo rm -rf /opt/nvim-macos-arm64
fi
sudo mv nvim-macos-arm64 /opt/
rm nvim-macos-arm64.tar.gz
sudo ln -sfv /opt/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim
