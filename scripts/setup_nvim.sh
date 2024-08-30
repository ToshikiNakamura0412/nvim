#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo ""
echo "setting Neovim... "
if [ -d ~/.local/share/nvim/plugged ]; then
    rm -rf ~/.local/share/nvim/plugged
fi
if [ -d ~/.config/nvim/undo ]; then
    rm -rf ~/.config/nvim/undo
fi
if [ -d ~/.config/coc ]; then
    rm -rf ~/.config/coc
fi
if [ ! -d ~/.config/nvim ]; then
    mkdir -pv ~/.config/nvim
fi
ln -sfv $SCRIPT_DIR/../init.vim ~/.config/nvim/init.vim
ln -sfv $SCRIPT_DIR/../configs/basic/basic-settings.vim ~/.config/nvim/basic-settings.vim
ln -sfv $SCRIPT_DIR/../configs/basic/keymap.vim ~/.config/nvim/keymap.vim
ln -sfv $SCRIPT_DIR/../configs/plugin/plugin-keymap.vim ~/.config/nvim/plugin-keymap.vim
ln -sfv $SCRIPT_DIR/../configs/plugin/plugin-settings.vim ~/.config/nvim/plugin-settings.vim
ln -sfv $SCRIPT_DIR/../configs/plugin/plugin.vim ~/.config/nvim/plugin.vim
ln -sfv $SCRIPT_DIR/../configs/others/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sfv $SCRIPT_DIR/../configs/others/clang-format ~/.clang-format
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim -c 'PlugInstall --sync' -c qa
echo ">>> Done"
echo ""
