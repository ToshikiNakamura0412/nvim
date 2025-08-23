#!/bin/bash

NIVM_ARCH=$(arch)
if [[ "$(arch)" == "aarch64" ]]; then
  NIVM_ARCH="arm64"
fi
NVIM_APP_DIR="$HOME/.local/bin"

# Ubuntu 22+ are supported for latest nvim
is_supported_distro_for_latest_nvim() {
  if [[ -e "/etc/os-release" ]]; then
    source /etc/os-release
    if [[ "${ID}" == "ubuntu" ]]; then
      local version_major=$(echo "${VERSION_ID}" | cut -d "." -f 1)
      if [[ "${version_major}" -ge 22 ]]; then
        return 0
      fi
  fi
  return 1
}

nvim_install_linux_app() {
  local app_dir="${NVIM_APP_DIR}"

  mkdir -pv "${app_dir}"
  if is_supported_distro_for_latest_nvim; then
    wget -vO "${app_dir}/nvim" "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-${NIVM_ARCH}.appimage"
  else
    if [[ "${NIVM_ARCH}" == "x86_64" ]]; then
      wget -vO "${app_dir}/nvim" "https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux-x86_64.appimage"
    elif [[ "${NIVM_ARCH}" == "arm64" ]]; then
      # wget -vO "${app_dir}/nvim" "
    fi
  fi
  chmod +x "${app_dir}/nvim"
}

nvim_install_linux_app_add_to_path() {
  if [[ -e "${NVIM_APP_DIR}/nvim" ]]; then
    local target_string="export PATH=\$HOME/.local/bin:\$PATH"
    local target_files=(
      "$HOME/.bashrc"
      "$HOME/.zshrc"
    )

    for target_file in "${target_files[@]}"; do
      if [[ -e "${target_file}" ]]; then
        if ! grep -q "${target_string}" ${target_file}; then
          echo "[INFO] Adding \"${target_string}\" to ${target_file}"
          echo "${target_string}" >> "${target_file}"
        fi
      fi
    done

    echo "[INFO] Neovim installed successfully. Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to update your PATH."
  else
    echo "[ERROR] Neovim installation failed. Please check the logs for errors."
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  if [[ "${NIVM_ARCH}" == "x86_64" ]] || [[ "${NIVM_ARCH}" == "arm64" ]]; then
    nvim_install_linux_app
    nvim_install_linux_app_add_to_path
  fi
fi
