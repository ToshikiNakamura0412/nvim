#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ "$(uname)" = "Linux" ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
elif [ "$(uname)" = "Darwin" ]; then
    OS_NAME="mac"
else
    echo "This OS is not supported."
    exit 1
fi

echo ""
echo "install prerequisites..."
$SCRIPT_DIR/scripts/install_prerequisites.sh
echo ">>> Done"
echo ""

$SCRIPT_DIR/scripts/setup_nvim.sh
