#!/bin/bash

NVIM_INSTALL_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

nvim_install() {
  local script_dir="${NVIM_INSTALL_SCRIPT_DIR}"
  "${script_dir}/scripts/install_prerequisites.sh"
  "${script_dir}/scripts/setup_nvim.sh"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  nvim_install
fi
