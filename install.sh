#!/bin/bash
echo "Installing Testsploit..."
mkdir -p ~/.local/bin
curl -sSL https://github.com/Tio30533/Testsploit/raw/refs/heads/main/testsploit -o ~/.local/bin/testsploit
chmod +x ~/.local/bin/testsploit
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/testsploit.desktop << 'EOF'
[Desktop Entry]
Name=Testsploit
Comment=Testsploit Application
Exec=pkexec /home/$USER/.local/bin/testsploit
Icon=system-run
Terminal=false
Type=Application
Categories=Utility;
EOF
echo "Installation complete! Find Testsploit in your app menu."