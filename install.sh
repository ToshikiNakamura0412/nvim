#!/bin/bash

NVIM_INSTALL_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

nvim_install() {
  local script_dir="${NVIM_INSTALL_SCRIPT_DIR}"
  "${script_dir}/scripts/install_prerequisites.sh"
  "${script_dir}/scripts/setup_nvim.sh"
}

nvim_install_show_help() {
  echo "[INFO] Neovim Installation Script"
  echo "[INFO] This script installs Neovim and its prerequisites"
  echo "[INFO] "
  echo "[INFO] Usage: $0 [option]"
  echo "[INFO] "
  echo "[INFO] Options:"
  echo "[INFO]   --help, -h            Show this help message."
  echo "[INFO]   --app-only            Install Neovim appimage only."
  echo "[INFO]   --no-fuse-nvim-app    Install Neovim appimage for non-FUSE environments."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  if [[ $# -eq 0 ]]; then
    nvim_install
    exit 0
  elif [[ "--help" == "$1" || "-h" == "$1" ]]; then
    nvim_install_show_help
    exit 0
  elif [[ "--app-only" == "$1" ]]; then
    "${NVIM_INSTALL_SCRIPT_DIR}/scripts/install_nvim_linux_app.sh"
    exit 0
  elif [[ "--no-fuse-nvim-app" == "$1" ]]; then
    "${NVIM_INSTALL_SCRIPT_DIR}/scripts/extract_no_fuse_nvim_app.sh"
    exit 0
  else
    echo "[ERROR] Invalid option: $1"
    nvim_install_show_help
    exit 1
  fi
fi
