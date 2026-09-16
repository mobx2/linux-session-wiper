#!/usr/bin/env bash
# ==============================================================================
# Linux Session Wiper - Health & Environment Check
# Non-destructive inspection tool to verify wiper target paths and dependencies.
# ==============================================================================

set -euo pipefail

CYAN='\033[38;5;51m'
GREEN='\033[38;5;82m'
YELLOW='\033[38;5;226m'
NC='\033[0m'

echo -e "${CYAN}[*] Linux Session Wiper Environment Health Check${NC}"
echo -e "    User: ${USER} | Host: $(hostname)"
echo ""

check_item() {
    local label="$1"
    local path="$2"
    if [ -e "$path" ]; then
        echo -e " ${GREEN}[+] Found:${NC}   ${label} (${path})"
    else
        echo -e " ${YELLOW}[-] Missing:${NC} ${label} (${path})"
    fi
}

echo -e "${CYAN}[*] Checking Shell Histories...${NC}"
check_item "Bash History" "${HOME}/.bash_history"
check_item "Zsh History"  "${HOME}/.zsh_history"
echo ""

echo -e "${CYAN}[*] Checking Browser Caches...${NC}"
check_item "Chrome Cache" "${HOME}/.cache/google-chrome"
check_item "Brave Cache"  "${HOME}/.cache/BraveSoftware"
check_item "Mozilla Cache" "${HOME}/.cache/mozilla"
echo ""

echo -e "${CYAN}[*] Checking Developer Directories...${NC}"
check_item "npm Cache"    "${HOME}/.npm"
check_item "Cursor Cache" "${HOME}/.cache/Cursor"
check_item "Windsurf Cache" "${HOME}/.cache/Windsurf"
echo ""

echo -e "${CYAN}[*] Checking Core Utilities...${NC}"
for cmd in shred pkill find rm; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e " ${GREEN}[+] Tool available:${NC} ${cmd}"
    else
        echo -e " ${YELLOW}[!] Tool missing:${NC}   ${cmd}"
    fi
done

echo ""
echo -e "${GREEN}[+] Health check completed. No changes were made to your system.${NC}"
