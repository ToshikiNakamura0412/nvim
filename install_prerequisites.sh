#!/bin/bash

# Prerequisites
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    curl \
    wget \
    fuse \
    libfuse2 \
    xsel \
    clangd \
    python3-pip \
    nodejs \
    npm
sudo pip3 install jedi-language-server pynvim
sudo npm install -y -g n
sudo n stable

# Neovim
sudo wget -O /opt/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo chmod +x /opt/nvim.appimage
sudo ln -sf /opt/nvim.appimage /usr/bin/vim
sudo ln -sf /opt/nvim.appimage /usr/bin/nvim
