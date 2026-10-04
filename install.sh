#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  PasarGuard Manager - Installer
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║         PasarGuard Manager Installer                     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Please run as root${NC}"
    exit 1
fi

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="pg-m"
SOURCE_URL="https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/pg-m"

echo -e "${CYAN}[+] Downloading PasarGuard Manager...${NC}"

# Try download from GitHub, fallback to local if available
if curl -fsSL "$SOURCE_URL" -o "/tmp/${SCRIPT_NAME}" 2>/dev/null; then
    echo -e "${GREEN}[+] Downloaded from GitHub${NC}"
else
    # Local fallback (when installing from extracted zip)
    if [[ -f "./pg-m" ]]; then
        cp "./pg-m" "/tmp/${SCRIPT_NAME}"
        echo -e "${GREEN}[+] Using local file${NC}"
    else
        echo -e "${RED}[ERROR] Could not download or find pg-m script${NC}"
        exit 1
    fi
fi

chmod +x "/tmp/${SCRIPT_NAME}"
mv "/tmp/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"

echo -e "${GREEN}[+] Installed successfully to ${INSTALL_DIR}/${SCRIPT_NAME}${NC}"
echo
echo -e "Run the menu with:  ${CYAN}pg-m${NC}"
echo
