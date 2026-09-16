#!/usr/bin/env bash
# ==============================================================================
# Linux Session Wiper - Cache Disk Usage Benchmark
# Analyzes reclaimable disk space across wiper target directories.
# ==============================================================================

set -euo pipefail

CYAN='\033[38;5;51m'
GREEN='\033[38;5;82m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}[*] Linux Session Wiper - Reclaimable Space Analyzer${NC}"
echo -e "    Scanning target directories for ${USER}..."
echo ""

measure_dir() {
    local label="$1"
    local path="$2"
    if [ -d "$path" ]; then
        local size
        size=$(du -sh "$path" 2>/dev/null | cut -f1 || echo "0B")
        echo -e "  ${label}: ${GREEN}${size}${NC} (${path})"
    else
        echo -e "  ${label}: 0B (not present)"
    fi
}

echo -e "${BOLD}Browser Caches:${NC}"
measure_dir "Chrome Cache"   "${HOME}/.cache/google-chrome"
measure_dir "Brave Cache"    "${HOME}/.cache/BraveSoftware"
measure_dir "Firefox Cache"  "${HOME}/.cache/mozilla"
echo ""

echo -e "${BOLD}Developer Caches:${NC}"
measure_dir "npm Cache"      "${HOME}/.npm"
measure_dir "Cursor Cache"   "${HOME}/.cache/Cursor"
measure_dir "Windsurf Cache" "${HOME}/.cache/Windsurf"
echo ""

echo -e "${BOLD}System & User Caches:${NC}"
measure_dir "Thumbnail Cache" "${HOME}/.cache/thumbnails"
echo ""

echo -e "${GREEN}[+] Analysis complete. Run 'wiper' to purge these caches.${NC}"
