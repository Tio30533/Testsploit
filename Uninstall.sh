#!/bin/bash

echo "Uninstalling Testsploit..."

rm -rf "$HOME/.local/share/testsploit"
rm -f "$HOME/.local/share/applications/testsploit.desktop"
sudo rm -f /usr/local/bin/testsploit

update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true

echo "Testsploit uninstalled."
