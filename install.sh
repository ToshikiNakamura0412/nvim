#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
OS_NAME=$1
if [ -z $OS_NAME ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
fi

echo ""
echo "install prerequisites..."
$SCRIPT_DIR/scripts/install_prerequisites.sh $OS_NAME
echo ">>> Done"
echo ""

$SCRIPT_DIR/scripts/setup_nvim.sh
