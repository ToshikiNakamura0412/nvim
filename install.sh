#!/bin/bash

echo ""
echo "install prerequisites..."
$SCRIPT_DIR/scripts/install_prerequisites.sh
echo ">>> Done"
echo ""

$SCRIPT_DIR/scripts/setup_nvim.sh
