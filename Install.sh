#!/bin/bash

# Testsploit Installer - ARM64 ONLY
ARCH=$(uname -m)
if [ "$ARCH" != "aarch64" ]; then
    echo "Error: This installer is for ARM64 (aarch64) systems only."
    echo "Your architecture: $ARCH"
    exit 1
fi

echo "Installing Testsploit for ARM64..."
echo ""

INSTALL_DIR="$HOME/.local/share/testsploit"
DESKTOP_DIR="$HOME/.local/share/applications"
DOWNLOAD_URL="https://github.com/Tio30533/Testsploit/releases/download/v1.0.0/testsploit"

mkdir -p "$INSTALL_DIR" "$DESKTOP_DIR"

# Download
echo "Downloading Testsploit..."
wget -q --show-progress "$DOWNLOAD_URL" -O "$INSTALL_DIR/testsploit" || {
    echo "Error: Failed to download Testsploit"
    exit 1
}
chmod +x "$INSTALL_DIR/testsploit"

# Set ptrace capability
echo "Setting permissions..."
sudo setcap cap_sys_ptrace=eip "$INSTALL_DIR/testsploit"

# Create wrapper script
cat > "$INSTALL_DIR/testsploit.sh" << 'WRAPEOF'
#!/bin/bash
export GSETTINGS_BACKEND=memory
export GTK_A11Y=none
exec "$HOME/.local/share/testsploit/testsploit" 2>/dev/null
WRAPEOF
chmod +x "$INSTALL_DIR/testsploit.sh"

# Create symlink
sudo ln -sf "$INSTALL_DIR/testsploit.sh" /usr/local/bin/testsploit

# Create desktop entry
cat > "$DESKTOP_DIR/testsploit.desktop" << DESKEOF
[Desktop Entry]
Name=Testsploit
Comment=Testsploit Application
Exec=$INSTALL_DIR/testsploit.sh
Icon=system-run
Terminal=false
Type=Application
Categories=Utility;
DESKEOF

update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true

echo ""
echo "✓ Installation complete!"
echo ""

read -p "Launch Testsploit now? (y/n): " LAUNCH
if [ "$LAUNCH" = "y" ] || [ "$LAUNCH" = "Y" ]; then
    "$INSTALL_DIR/testsploit.sh" &
fi
