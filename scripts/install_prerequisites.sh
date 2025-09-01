#!/bin/bash

NVIM_INSTALL_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
  local script_dir=${NVIM_INSTALL_SCRIPT_DIR}

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
    pip3 install pynvim pyright
    sudo npm install -y -g n
    sudo n stable
    curl -fLo ~/.local/share/fonts/HackNerdFont-Regular.ttf --create-dirs \
      https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf

    # Neovim
    "${script_dir}/install_nvim_linux_app.sh"

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
    brew install node
    sudo npm install -y -g n
    sudo n stable
    pip3 install pynvim pyright
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
