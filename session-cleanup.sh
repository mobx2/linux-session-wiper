#!/usr/bin/env bash

RED='\033[1;31m'
CYAN='\033[0m\033[1;36m'
NC='\033[0m'

clear
echo -e "${RED}[!] SECURE EXIT: CLEANING SESSION${NC}"
echo -e "${CYAN}---------------------------------${NC}"
sleep 0.5

echo " [*] Clearing shell history..."
history -c 2>/dev/null || true

rm -f ~/.bash_history ~/.zsh_history 2>/dev/null

touch ~/.bash_history ~/.zsh_history
chmod 600 ~/.bash_history ~/.zsh_history

echo " [*] Terminating user SSH sessions..."
pkill -u "$USER" -x ssh 2>/dev/null || true

echo " [*] Cleaning user cache and tmp files..."
rm -rf ~/.cache/thumbnails/* 2>/dev/null || true

find /tmp -user "$USER" -type f -delete 2>/dev/null || true
find /tmp -user "$USER" -type d -empty -delete 2>/dev/null || true

echo " [*] Cleanup complete. Closing window..."
sleep 0.5

kill -HUP $PPID
