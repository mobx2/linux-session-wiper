#!/usr/bin/env bash
# ==============================================================================
# Linux Session Wiper - Uninstaller
# Cleanly removes system-wide binaries, systemd units, and completions.
# ==============================================================================

set -e

GREEN='\033[38;5;82m'
CYAN='\033[38;5;51m'
YELLOW='\033[38;5;226m'
RED='\033[38;5;196m'
NC='\033[0m'

echo -e "${YELLOW}[!] Linux Session Wiper Uninstaller${NC}"
echo -en "${CYAN}[?] Are you sure you want to completely remove wiper? [y/N]: ${NC}"
read -r confirm

case "$confirm" in
    [yY]|[yY][eE][sS])
        echo -e "\n${CYAN}[*] Removing system binary (/usr/local/bin/wiper)...${NC}"
        if [ -f "/usr/local/bin/wiper" ]; then
            if [ "$EUID" -ne 0 ]; then
                sudo rm -f /usr/local/bin/wiper 2>/dev/null || true
            else
                rm -f /usr/local/bin/wiper 2>/dev/null || true
            fi
        fi

        echo -e "${CYAN}[*] Disabling and removing systemd user unit (if enabled)...${NC}"
        systemctl --user stop wiper-on-logout.service 2>/dev/null || true
        systemctl --user disable wiper-on-logout.service 2>/dev/null || true
        rm -f "$HOME/.config/systemd/user/wiper-on-logout.service" 2>/dev/null || true
        systemctl --user daemon-reload 2>/dev/null || true

        echo -e "${CYAN}[*] Removing shell completion files (if present)...${NC}"
        rm -f "/etc/bash_completion.d/wiper" 2>/dev/null || true
        rm -f "$HOME/.local/share/bash-completion/completions/wiper" 2>/dev/null || true

        echo -e "\n${GREEN}[+] Linux Session Wiper has been successfully uninstalled.${NC}"
        ;;
    *)
        echo -e "\n${CYAN}[*] Uninstall cancelled.${NC}"
        exit 0
        ;;
esac
