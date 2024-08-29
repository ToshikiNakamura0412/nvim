#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo ""
echo "install prerequisites..."
$SCRIPT_DIR/scripts/install_prerequisites_macos_arm64.sh
echo ">>> Done"
echo ""
$SCRIPT_DIR/scripts/setup_nvim.sh
echo ""
echo "==="
echo "Finish!!"
echo "==="
