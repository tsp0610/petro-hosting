#!/bin/bash

# Benar ASCII Art Banne

# Function: Install (Fresh Setup)
install_tsp() {
    echo ">>> Starting Fresh Install for TSP Hosting..."

    # --- Step 1: Install Node.js 20.x ---
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
      sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | \
      sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt-get update
    sudo apt-get install -y nodejs

    # --- Step 2: Install Yarn, Dependencies & TSP Hosting Release ---
    npm i -g yarn
    cd /var/www/pterodactyl
    yarn
    sudo apt install -y zip unzip git curl wget

    echo ">>> Downloading latest TSP Hosting release..."
    wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | \
    grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip

    echo ">>> Extracting release files..."
    unzip -o release.zip

    # --- Step 3: Run TSP Hosting Installer ---
    if [ ! -f "blueprint.sh" ]; then
        echo "❌ Error: blueprint.sh not found in release package."
        exit 1
    fi

    chmod +x blueprint.sh
    bash blueprint.sh
}

# Function: Reinstall (Rerun Only)
reinstall_tsp() {
    echo ">>> Starting Reinstall for TSP Hosting..."
    blueprint -rerun-install
}

# Function: Update TSP Hosting
update_tsp() {
    echo ">>> Starting Update for TSP Hosting..."
    blueprint -upgrade
    echo "✅ Update completed!"
}

# --- Menu Selector ---
while true; do
    echo ""
    echo "============================"
    echo " Blueprint Installer"
    echo "============================"
    echo "1) Install (Fresh Install)"
    echo "2) Reinstall (Rerun Only)"
    echo "3) Update TSP Hosting"
    echo "0) Exit"
    echo "============================"
    read -p "👉 Select option: " choice

    case $choice in
        1) install_tsp ;;
        2) reinstall_tsp ;;
        3) update_tsp ;;
        0) echo "Exiting..."; exit 0 ;;
        *) echo "⚠️ Invalid choice, try again!" ;;
    esac
done
