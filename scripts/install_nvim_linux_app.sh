#!/bin/bash

NIVM_ARCH=$(arch)
if [[ "$(arch)" == "aarch64" ]]; then
  NIVM_ARCH="arm64"
fi

nvim_install_linux_app() {
  local app_dir="$HOME/.local/bin"

  mkdir -pv "${app_dir}"
  wget -vO "${app_dir}/nvim" "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-${NIVM_ARCH}.appimage"
  chmod +x "${app_dir}/nvim"
}

nvim_install_linux_app_add_to_path() {
  local target_string="export PATH=\$HOME/.local/bin:\$PATH"
  local target_files=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
  )
  for target_file in "${target_files[@]}"; do
    if [[ -e "${target_file}" ]]; then
      if ! grep -q "${target_string}" ${target_file}; then
        echo "Adding \"${target_string}\" to ${target_file}"
        echo "${target_string}" >> "${target_file}"
      fi
    fi
  done
  echo "${target_string}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  if [[ "${NIVM_ARCH}" == "x86_64" ]] || [[ "${NIVM_ARCH}" == "arm64" ]]; then
    nvim_install_linux_app
    nvim_install_linux_app_add_to_path
  fi
fi
