#!/bin/bash

NVIM_INSTALL_MINI_PACK_BASE=(
  curl
  xsel
  python3
  neovim
)
NVIM_INSTALL_MINI_PACK_PIP=(
  pynvim
  jedi
)

nvim_get_os_name() {
  if [[ "$(uname)" = "Linux" ]]; then
    source /etc/os-release
    echo "${ID}"
  elif [[ "$(uname)" = "Darwin" ]]; then
    echo "mac"
  else
    echo "[ERROR] This OS is not supported."
    exit 1
  fi
}

nvim_install_prerequisites() {
  local os_name=$(nvim_get_os_name)

  echo ""
  echo "[INFO] Installing prerequisites for Neovim..."
  if [[ "${os_name}" == "ubuntu" ]] || [[ "${os_name}" == "debian" ]]; then
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
    if [[ "$(arch)" == "x86_64" ]]; then
      sudo wget -vO /opt/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
      sudo chmod +x /opt/nvim.appimage
      sudo ln -sf /opt/nvim.appimage /usr/bin/nvim
    elif [[ "$(arch)" == "aarch64" ]]; then
      # Choose between appimage or build
      APP_TYPE="appimage"
      if [[ "${APP_TYPE}" == "appimage" ]]; then
        sudo wget -vO /opt/nvim.appimage https://github.com/matsuu/neovim-aarch64-appimage/releases/download/v0.10.1/nvim-v0.10.1-aarch64.appimage
        sudo chmod +x /opt/nvim.appimage
        sudo ln -sf /opt/nvim.appimage /usr/local/bin/nvim
      elif [[ "${APP_TYPE}" == "build" ]]; then
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

  elif [[ "${os_name}" == "alpine" ]]; then
    sudo apk update && sudo apk add --no-cache "${NVIM_INSTALL_MINI_PACK_BASE[@]}" py3-pip
    pip3 install "${NVIM_INSTALL_MINI_PACK_PIP[@]}"

  elif [[ "${os_name}" == "arch" ]]; then
    sudo pacman -Sy --noconfirm "${NVIM_INSTALL_MINI_PACK_BASE[@]}" python-pip
    pip install "${NVIM_INSTALL_MINI_PACK_PIP[@]}"

  elif [[ "${os_name}" == "fedora" ]]; then
    sudo dnf check-update || true && sudo dnf install -y --setopt=install_weak_deps=False "${NVIM_INSTALL_MINI_PACK_BASE[@]}" python3-pip
    pip3 install "${NVIM_INSTALL_MINI_PACK_PIP[@]}"

  elif [[ "${os_name}" == "opensuse-leap" ]]; then
    sudo zypper refresh && sudo zypper install -y --no-recommends "${NVIM_INSTALL_MINI_PACK_BASE[@]}" python3-pip
    pip3 install "${NVIM_INSTALL_MINI_PACK_PIP[@]}"

  elif [[ "${os_name}" == "mac" ]]; then
    # Prerequisites
    pip3 install "${NVIM_INSTALL_MINI_PACK_PIP[@]}"
    if [[ ! -d /Library/Fonts ]]; then
      sudo mkdir -pv /Library/Fonts
    fi
    cd /Library/Fonts && sudo curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf

    # Neovim
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-macos-arm64.tar.gz
    tar xzf nvim-macos-arm64.tar.gz
    if [[ -d /opt/nvim-macos-arm64 ]]; then
      sudo rm -rf /opt/nvim-macos-arm64
    fi
    sudo mv nvim-macos-arm64 /opt/
    rm nvim-macos-arm64.tar.gz
    sudo ln -sfv /opt/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim
  fi
  echo "[INFO] >>> Done"
  echo ""
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  nvim_install_prerequisites
fi
