#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  PasarGuard Manager - Installer (v2.2.1)
# ═══════════════════════════════════════════════════════════════
set -uo pipefail

RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; CYAN=$'\033[0;36m'; NC=$'\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║         PasarGuard Manager Installer                     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

[[ $EUID -eq 0 ]] || { echo -e "${RED}Please run as root${NC}"; exit 1; }

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="pg-m"
SOURCE_URL="https://raw.githubusercontent.com/SiNaKeEn/NexusNet-PasarGuard/Manager/pg-m"
TMP="$(mktemp /tmp/pg-m.XXXXXX)"
trap 'rm -f "$TMP"' EXIT

# make sure curl exists on minimal images
if ! command -v curl >/dev/null 2>&1; then
    echo -e "${CYAN}[+] Installing curl...${NC}"
    apt-get update -qq && apt-get install -y -qq curl ca-certificates >/dev/null 2>&1
fi

echo -e "${CYAN}[+] Downloading PasarGuard Manager...${NC}"
if curl -fsSL --max-time 60 "$SOURCE_URL" -o "$TMP" 2>/dev/null && head -1 "$TMP" | grep -q '^#!' && bash -n "$TMP" 2>/dev/null; then
    echo -e "${GREEN}[+] Downloaded from GitHub${NC}"
elif [[ -f "./pg-m" ]]; then
    cp "./pg-m" "$TMP"
    echo -e "${GREEN}[+] Using local file${NC}"
else
    echo -e "${RED}[ERROR] Could not download or find pg-m script${NC}"
    exit 1
fi

# keep the previous version as a fallback
[[ -f "${INSTALL_DIR}/${SCRIPT_NAME}" ]] && cp -f "${INSTALL_DIR}/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}.bak"

install -m 755 "$TMP" "${INSTALL_DIR}/${SCRIPT_NAME}"
VER=$("${INSTALL_DIR}/${SCRIPT_NAME}" --version 2>/dev/null || echo "pg-m")

echo -e "${GREEN}[+] Installed successfully: ${VER} → ${INSTALL_DIR}/${SCRIPT_NAME}${NC}"
echo
echo -e "Run the menu with:  ${CYAN}pg-m${NC}"
echo -e "Quick commands   :  ${CYAN}pg-m doctor${NC} | ${CYAN}pg-m db${NC} | ${CYAN}pg-m backup${NC}"
echo
