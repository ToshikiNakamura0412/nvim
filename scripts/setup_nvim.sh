#!/bin/bash

NVIM_SETUP_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

nvim_setup() {
  local script_dir="${NVIM_SETUP_SCRIPT_DIR}"

  echo ""
  echo "[INFO] setting Neovim... "
  if [[ -d ~/.local/share/nvim/plugged ]]; then
      rm -rf ~/.local/share/nvim/plugged
  fi
  if [[ -d ~/.config/nvim/undo ]]; then
      rm -rf ~/.config/nvim/undo
  fi
  if [[ -d ~/.config/coc ]]; then
      rm -rf ~/.config/coc
  fi
  if [[ ! -d ~/.config/nvim ]]; then
      mkdir -pv ~/.config/nvim
  fi
  ln -sfv ${script_dir}/../init.vim ~/.config/nvim/init.vim
  ln -sfv ${script_dir}/../configs/basic/basic-settings.vim ~/.config/nvim/basic-settings.vim
  ln -sfv ${script_dir}/../configs/basic/keymap.vim ~/.config/nvim/keymap.vim
  ln -sfv ${script_dir}/../configs/plugin/plugin-keymap.vim ~/.config/nvim/plugin-keymap.vim
  ln -sfv ${script_dir}/../configs/plugin/plugin-settings.vim ~/.config/nvim/plugin-settings.vim
  ln -sfv ${script_dir}/../configs/plugin/plugin.vim ~/.config/nvim/plugin.vim
  ln -sfv ${script_dir}/../configs/others/coc-settings.json ~/.config/nvim/coc-settings.json
  ln -sfv ${script_dir}/../configs/others/clang-format ~/.clang-format
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "[INFO] >>> Done"
  echo ""
}

nvim_setup_add_to_path() {
  if [[ -e "$HOME/.local/bin/nvim" ]]; then
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
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  nvim_setup
  nvim_setup_add_to_path
fi
