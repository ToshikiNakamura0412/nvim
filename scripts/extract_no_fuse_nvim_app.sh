#!/bin/bash

mkdir -pv ~/.local/opt ~/.local/bin
cd ~/.local/opt && nvim --appimage-extract
ln -sfv ~/.local/opt/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
