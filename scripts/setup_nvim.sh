#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo ""
echo "setting Neovim... "
if [ ! -d ~/.config/nvim ]; then
    mkdir -pv ~/.config/nvim
fi
ln -sfv $SCRIPT_DIR/../init.vim ~/.config/nvim/init.vim
ln -sfv $SCRIPT_DIR/../configs/basic-settings.vim ~/.config/nvim/basic-settings.vim
ln -sfv $SCRIPT_DIR/../configs/keymap.vim ~/.config/nvim/keymap.vim
ln -sfv $SCRIPT_DIR/../configs/plugin-keymap.vim ~/.config/nvim/plugin-keymap.vim
ln -sfv $SCRIPT_DIR/../configs/plugin-settings.vim ~/.config/nvim/plugin-settings.vim
ln -sfv $SCRIPT_DIR/../configs/plugin.vim ~/.config/nvim/plugin.vim
ln -sfv $SCRIPT_DIR/../coc-settings.json ~/.config/nvim/coc-settings.json
ln -sfv $SCRIPT_DIR/../clang-format ~/.clang-format
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c 'PlugInstall --sync' -c qa
echo ">>> Done"
echo ""
