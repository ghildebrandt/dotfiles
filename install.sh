#!/bin/bash

# Farben für die Ausgabe
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Starte WSL Setup...${NC}"

# 1. System Update
sudo apt update && sudo apt upgrade -y

# 2. Wichtige Tools installieren
echo -e "${GREEN}Installiere Basis-Tools...${NC}"
sudo apt install -y zsh curl git build-essential vim wget unzip

# 3. Zsh & Oh My Zsh einrichten
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installiere Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. Symlinks erstellen (Verknüpft Dateien aus dem Repo mit dem Home-Verzeichnis)
echo "Erstelle Symlinks..."
ln -sf ~/src/dotfiles/.zshrc ~/.zshrc
ln -sf ~/src/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.ssh
ln -sf ~/src/dotfiles/.ssh_config ~/.ssh/config

# 5. Zusätzliche Tools (Beispiel: uv oder nvm)
if ! command -v uv &> /dev/null; then
    echo "Installiere uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# 6. Standard-Shell auf Zsh setzen
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo "Wechsle Standard-Shell zu Zsh..."
    sudo chsh -s $(which zsh) $USER
fi

echo -e "${GREEN}Setup abgeschlossen! Starte die Shell neu.${NC}"