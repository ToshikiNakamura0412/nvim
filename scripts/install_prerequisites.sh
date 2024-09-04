#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ "$(uname)" = "Linux" ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
elif [ "$(uname)" = "Darwin" ]; then
    OS_NAME="mac"
else
    echo "This OS is not supported."
    exit 1
fi

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
        # Choose between appimage or build
        APP_TYPE="appimage"
        if [ $APP_TYPE = "appimage" ]; then
            sudo wget -vO /opt/nvim.appimage https://github.com/matsuu/neovim-aarch64-appimage/releases/download/v0.10.1/nvim-v0.10.1-aarch64.appimage
            sudo chmod +x /opt/nvim.appimage
            sudo ln -sf /opt/nvim.appimage /usr/local/bin/nvim
        elif [ $APP_TYPE = "build" ]; then
            sudo apt-get update && sudo apt-get install -y --no-install-recommends \
                unzip \
                gettext \
                cmake \
                ninja-build \
                build-essential \
                ca-certificates
            git clone -b stable --single-branch --depth 1 https://github.com/neovim/neovim ~/neovim
            cd ~/neovim
            make appimage
            sudo make install
            rm -rf ~/neovim
        fi
    fi

elif [ $OS_NAME = "alpine" ]; then
    sudo apk update && sudo apk add \
        curl \
        xsel \
        python3 \
        py3-pip \
        neovim
    pip3 install pynvim jedi

elif [ $OS_NAME = "fedora" ]; then
    sudo dnf check-update || true && sudo dnf install -y \
        curl \
        xsel \
        python3 \
        python3-pip \
        neovim
    pip3 install pynvim jedi

elif [ $OS_NAME = "mac" ]; then
    # Prerequisites
    pip3 install pynvim jedi
    if [ ! -d /Library/Fonts ]; then
        sudo mkdir -pv /Library/Fonts
    fi
    cd /Library/Fonts && sudo curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf

    # Neovim
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-macos-arm64.tar.gz
    tar xzf nvim-macos-arm64.tar.gz
    if [ -d /opt/nvim-macos-arm64 ]; then
        sudo rm -rf /opt/nvim-macos-arm64
    fi
    sudo mv nvim-macos-arm64 /opt/
    rm nvim-macos-arm64.tar.gz
    sudo ln -sfv /opt/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim
fi
