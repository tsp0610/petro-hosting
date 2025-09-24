#!/bin/bash

# Benar ASCII Art Banner
cat << "EOF"
  _______ _____ _____  
 |__   __/ ____|  __ \ 
    | | | (___ | |__) |
    | |  \___ \|  ___/ 
    | |  ____) | |     
    |_| |_____/|_|     
EOF

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Start Tailscale service

# Attempt auto-connect using placeholder key
sudo tailscale up 

echo "Tailscale setup attempted. Login."
