#!/bin/bash

source /etc/os-release
OS_NAME=$(echo $ID)

if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ]; then
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
        npm \
        ripgrep
    pip3 install jedi-language-server pynvim
    sudo npm install -y -g n
    sudo n stable
    curl -fLo ~/.local/share/fonts/HackNerdFont-Regular.ttf --create-dirs \
        https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf

    # Neovim
    if [ $(arch) = "x86_64" ]; then
        sudo wget -vO /opt/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
        sudo chmod +x /opt/nvim.appimage
        sudo ln -sf /opt/nvim.appimage /usr/bin/nvim
    elif [ $(arch) = "aarch64" ]; then
        sudo apt-get update && sudo apt-get install -y --no-install-recommends \
            ninja-build \
            gettext \
            cmake \
            unzip \
            build-essential \
            ca-certificates
        git clone https://github.com/neovim/neovim.git
        cd neovim
        git checkout stable
        make CMAKE_BUILD_TYPE=RelWithDebInfo
        sudo make install
        rm -rf neovim
    fi

elif [ $OS_NAME = "alpine" ]; then
    sudo apk update && sudo apk add \
        curl \
        xsel \
        python3 \
        py3-pip \
        neovim
    pip3 install pynvim
fi
