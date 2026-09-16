#!/usr/bin/env bash
# ==============================================================================
# Linux Session Wiper - Cyberpunk Edition
# Advanced, interactive terminal session and privacy cleaner for Linux.
# ==============================================================================

# ANSI Color Palette
GREEN='\033[38;5;82m'
CYAN='\033[38;5;51m'
RED='\033[38;5;196m'
YELLOW='\033[38;5;226m'
MAGENTA='\033[38;5;201m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m' # No Color

# ------------------------------------------------------------------------------
# Banner and UI Helpers
# ------------------------------------------------------------------------------
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << 'EOF'
  ____  _____ ____ ____ ___ ___  _   _   __        _____ ____  _____ ____  
 / ___|| ____/ ___/ ___|_ _/ _ \| \ | |  \ \      / /_ _|  _ \| ____|  _ \ 
 \___ \|  _| \___ \___ \| | | | |  \| |   \ \ /\ / / | || |_) |  _| | |_) |
  ___) | |___ ___) |__) | | |_| | |\  |    \ V  V /  | ||  __/| |___|  _ < 
 |____/|_____|____/____/___\___/|_| \_|     \_/\_/  |___|_|   |_____|_| \_\
EOF
    echo -e "${MAGENTA}======================================================================${NC}"
    echo -e "${GREEN}${BOLD} ${NC} ${DIM}| User: ${USER} | Host: $(hostname)${NC}"
    echo -e "${MAGENTA}======================================================================${NC}"
    echo ""
}

show_menu() {
    echo -e "${BOLD}${CYAN}Available Modules:${NC}"
    echo -e "  ${RED}${BOLD}[1]${NC} ${BOLD}Nuke Everything${NC} ${DIM}(All Modules + Exit)${NC}"
    echo -e "  ${GREEN}[2]${NC} Wipe Shell History ${DIM}(Bash & Zsh secure reset)${NC}"
    echo -e "  ${GREEN}[3]${NC} Wipe Browser Data ${DIM}(Chrome, Firefox, Brave cache, cookies & history)${NC}"
    echo -e "  ${GREEN}[4]${NC} Wipe Developer Caches ${DIM}(npm, Next.js, Cursor, Windsurf)${NC}"
    echo -e "  ${GREEN}[5]${NC} Wipe Session & /tmp ${DIM}(SSH sessions, thumbnails, /tmp files)${NC}"
    echo -e "  ${YELLOW}[6]${NC} Exit & Close Terminal"
    echo ""
}

pause_prompt() {
    echo ""
    echo -en "${CYAN}[>] Press [Enter] to return to the menu...${NC}"
    read -r _ || return 0
}

# ------------------------------------------------------------------------------
# Exit Routine
# ------------------------------------------------------------------------------
exit_routine() {
    clear
    kill -HUP "$PPID" 2>/dev/null || true
    exit 0
}

# ------------------------------------------------------------------------------
# Module 1: Shell History
# ------------------------------------------------------------------------------
wipe_shell_history() {
    echo -e "\n${BOLD}${CYAN}[*] Executing: Shell History Wipe...${NC}"
    
    # In-memory history reset
    echo -e " ${CYAN}[*] Clearing in-memory shell history...${NC}"
    history -c 2>/dev/null || true
    history -w /dev/null 2>/dev/null || true

    # Bash history
    if [ -f "$HOME/.bash_history" ]; then
        echo -e " ${CYAN}[*] Securely shredding ~/.bash_history...${NC}"
        if command -v shred >/dev/null 2>&1; then
            shred -u -z -n 3 "$HOME/.bash_history" 2>/dev/null || true
        else
            rm -f "$HOME/.bash_history" 2>/dev/null || true
        fi
        touch "$HOME/.bash_history" 2>/dev/null || true
        chmod 600 "$HOME/.bash_history" 2>/dev/null || true
    fi

    # Zsh history
    if [ -f "$HOME/.zsh_history" ]; then
        echo -e " ${CYAN}[*] Securely shredding ~/.zsh_history...${NC}"
        if command -v shred >/dev/null 2>&1; then
            shred -u -z -n 3 "$HOME/.zsh_history" 2>/dev/null || true
        else
            rm -f "$HOME/.zsh_history" 2>/dev/null || true
        fi
        touch "$HOME/.zsh_history" 2>/dev/null || true
        chmod 600 "$HOME/.zsh_history" 2>/dev/null || true
    fi

    # Extra session artifacts
    rm -rf "$HOME/.bash_sessions" 2>/dev/null || true
    rm -f "$HOME/.sh_history" 2>/dev/null || true

    echo -e " ${GREEN}[+] Shell histories successfully cleared and reset.${NC}"
}

# ------------------------------------------------------------------------------
# Module 2: Browser Wipe (Targeted privacy: cookies, caches, history)
# ------------------------------------------------------------------------------
wipe_browsers() {
    echo -e "\n${BOLD}${CYAN}[*] Executing: Browser Wipe...${NC}"

    # Terminate active browser processes to unlock SQLite databases and avoid memory flushes
    echo -e " ${CYAN}[*] Closing active browser processes (Chrome, Brave, Firefox)...${NC}"
    pkill -u "$USER" -x chrome 2>/dev/null || true
    pkill -u "$USER" -x google-chrome 2>/dev/null || true
    pkill -u "$USER" -x google-chrome-stable 2>/dev/null || true
    pkill -u "$USER" -x brave 2>/dev/null || true
    pkill -u "$USER" -x brave-browser 2>/dev/null || true
    pkill -u "$USER" -x firefox 2>/dev/null || true
    pkill -u "$USER" -x firefox-bin 2>/dev/null || true
    sleep 0.5

    # Caches in ~/.cache
    echo -e " ${CYAN}[*] Purging browser cache directories in ~/.cache...${NC}"
    rm -rf "$HOME/.cache/google-chrome"* 2>/dev/null || true
    rm -rf "$HOME/.cache/chromium"* 2>/dev/null || true
    rm -rf "$HOME/.cache/BraveSoftware"* 2>/dev/null || true
    rm -rf "$HOME/.cache/mozilla"* 2>/dev/null || true

    # Targeted Chromium-based cleanup (Chrome, Brave)
    echo -e " ${CYAN}[*] Cleaning cookies, history, and session data for Chrome and Brave...${NC}"
    local chromium_dirs=(
        "$HOME/.config/google-chrome"
        "$HOME/.config/chromium"
        "$HOME/.config/BraveSoftware/Brave-Browser"
    )

    for base_dir in "${chromium_dirs[@]}"; do
        if [ -d "$base_dir" ]; then
            # Search profiles within base_dir (Default, Profile 1, etc.)
            find "$base_dir" -maxdepth 2 -type d \( -name "Default" -o -name "Profile *" \) 2>/dev/null | while read -r profile_dir; do
                # Cache and temporary storage
                rm -rf "$profile_dir/Cache" 2>/dev/null || true
                rm -rf "$profile_dir/Code Cache" 2>/dev/null || true
                rm -rf "$profile_dir/GPUCache" 2>/dev/null || true
                rm -rf "$profile_dir/Service Worker/CacheStorage" 2>/dev/null || true
                rm -rf "$profile_dir/Session Storage" 2>/dev/null || true
                rm -rf "$profile_dir/IndexedDB" 2>/dev/null || true

                # Cookies, History, and Session state files
                rm -f "$profile_dir/Cookies"* 2>/dev/null || true
                rm -f "$profile_dir/Network/Cookies"* 2>/dev/null || true
                rm -f "$profile_dir/History"* 2>/dev/null || true
                rm -f "$profile_dir/Shortcuts"* 2>/dev/null || true
                rm -f "$profile_dir/Top Sites"* 2>/dev/null || true
                rm -f "$profile_dir/Visited Links"* 2>/dev/null || true
                rm -f "$profile_dir/Web Data"* 2>/dev/null || true
                rm -f "$profile_dir/Last Session"* 2>/dev/null || true
                rm -f "$profile_dir/Last Tabs"* 2>/dev/null || true
                rm -f "$profile_dir/Current Session"* 2>/dev/null || true
                rm -f "$profile_dir/Current Tabs"* 2>/dev/null || true
            done
        fi
    done

    # Firefox cleanup
    echo -e " ${CYAN}[*] Cleaning cookies, history, and session storage for Firefox...${NC}"
    local ff_dir="$HOME/.mozilla/firefox"
    if [ -d "$ff_dir" ]; then
        find "$ff_dir" -maxdepth 2 -type d -name "*.default*" 2>/dev/null | while read -r ff_profile; do
            rm -rf "$ff_profile/cache2" 2>/dev/null || true
            rm -rf "$ff_profile/startupCache" 2>/dev/null || true
            rm -rf "$ff_profile/jumpListCache" 2>/dev/null || true
            rm -rf "$ff_profile/storage/default" 2>/dev/null || true
            rm -f "$ff_profile/cookies.sqlite"* 2>/dev/null || true
            rm -f "$ff_profile/places.sqlite"* 2>/dev/null || true
            rm -f "$ff_profile/formhistory.sqlite"* 2>/dev/null || true
            rm -f "$ff_profile/sessionstore.jsonlz4"* 2>/dev/null || true
            rm -rf "$ff_profile/sessionstore-backups" 2>/dev/null || true
            rm -f "$ff_profile/webappsstore.sqlite"* 2>/dev/null || true
        done
    fi

    echo -e " ${GREEN}[+] Browser history, cookies, and caches successfully wiped.${NC}"
}

# ------------------------------------------------------------------------------
# Module 3: Developer Wipe (npm, Next.js, Cursor, Windsurf)
# ------------------------------------------------------------------------------
wipe_dev_cache() {
    echo -e "\n${BOLD}${CYAN}[*] Executing: Developer Wipe...${NC}"

    # npm cache
    echo -e " ${CYAN}[*] Clearing npm cache...${NC}"
    if command -v npm >/dev/null 2>&1; then
        npm cache clean --force 2>/dev/null || true
    fi
    rm -rf "$HOME/.npm" 2>/dev/null || true

    # Next.js cache (current directory and projects folder up to depth 4)
    echo -e " ${CYAN}[*] Clearing Next.js build caches (.next/cache)...${NC}"
    rm -rf "$PWD/.next/cache" 2>/dev/null || true
    find "$PWD" -maxdepth 4 -type d -path "*/.next/cache" -prune -exec rm -rf {} + 2>/dev/null || true

    if [ -d "$HOME/projects" ]; then
        find "$HOME/projects" -maxdepth 4 -type d -path "*/.next/cache" -prune -exec rm -rf {} + 2>/dev/null || true
    fi

    # Cursor cache
    echo -e " ${CYAN}[*] Clearing Cursor editor caches and logs...${NC}"
    rm -rf "$HOME/.cache/Cursor" 2>/dev/null || true
    rm -rf "$HOME/.config/Cursor/Cache"* 2>/dev/null || true
    rm -rf "$HOME/.config/Cursor/CachedData"* 2>/dev/null || true
    rm -rf "$HOME/.config/Cursor/Code Cache"* 2>/dev/null || true
    rm -rf "$HOME/.config/Cursor/GPUCache"* 2>/dev/null || true
    rm -rf "$HOME/.config/Cursor/logs"* 2>/dev/null || true

    # Windsurf cache
    echo -e " ${CYAN}[*] Clearing Windsurf editor caches and logs...${NC}"
    rm -rf "$HOME/.cache/Windsurf" 2>/dev/null || true
    rm -rf "$HOME/.config/Windsurf/Cache"* 2>/dev/null || true
    rm -rf "$HOME/.config/Windsurf/CachedData"* 2>/dev/null || true
    rm -rf "$HOME/.config/Windsurf/Code Cache"* 2>/dev/null || true
    rm -rf "$HOME/.config/Windsurf/GPUCache"* 2>/dev/null || true
    rm -rf "$HOME/.config/Windsurf/logs"* 2>/dev/null || true

    echo -e " ${GREEN}[+] Developer caches successfully wiped.${NC}"
}

# ------------------------------------------------------------------------------
# Module 4: Session & Tmp Wipe (SSH, Thumbnails, /tmp)
# ------------------------------------------------------------------------------
wipe_session_tmp() {
    echo -e "\n${BOLD}${CYAN}[*] Executing: Session & /tmp Wipe...${NC}"

    # Terminate user SSH sessions
    echo -e " ${CYAN}[*] Terminating active SSH sessions...${NC}"
    pkill -u "$USER" -x ssh 2>/dev/null || true

    # Thumbnail cache
    echo -e " ${CYAN}[*] Forcefully clearing thumbnail cache...${NC}"
    rm -rf "$HOME/.cache/thumbnails"/* 2>/dev/null || true

    # Temporary files owned by user
    echo -e " ${CYAN}[*] Purging /tmp files owned by $USER...${NC}"
    find /tmp -user "$USER" -type f -delete 2>/dev/null || true
    find /tmp -user "$USER" -type d -empty -delete 2>/dev/null || true

    echo -e " ${GREEN}[+] Session and temporary files cleared.${NC}"
}

# ------------------------------------------------------------------------------
# Module 5: Nuke Everything (All Modules + Confirmation + Exit)
# ------------------------------------------------------------------------------
nuke_everything() {
    echo -e "\n${RED}${BOLD}[!] WARNING: You are about to NUKE all session data, histories, caches, and active SSH sessions.${NC}"
    echo -en "${YELLOW}[?] Are you sure you want to NUKE everything? [y/N]: ${NC}"
    if ! read -r confirm; then
        echo -e "\n${CYAN}[*] Nuke operation cancelled. Returning to menu.${NC}"
        return 0
    fi
    case "$confirm" in
        [yY]|[yY][eE][sS])
            echo -e "\n${RED}[!] INITIATING FULL SYSTEM SESSION PURGE...${NC}"
            wipe_shell_history
            wipe_browsers
            wipe_dev_cache
            wipe_session_tmp
            echo -e "\n${GREEN}${BOLD}[+] Full purge complete. Closing terminal window in 2 seconds...${NC}"
            sleep 2
            exit_routine
            ;;
        *)
            echo -e "\n${CYAN}[*] Nuke operation cancelled. Returning to menu.${NC}"
            sleep 1
            ;;
    esac
}

# ------------------------------------------------------------------------------
# Main Execution Loop
# ------------------------------------------------------------------------------
main() {
    # Ensure script permissions
    chmod +x "$0" 2>/dev/null || true

    while true; do
        show_banner
        show_menu
        echo -en "${CYAN}[?] Select an option [1-6]: ${NC}"
        if ! read -r choice; then
            echo -e "\n${CYAN}[*] Session wiper closed.${NC}"
            break
        fi
        case "$choice" in
            1)
                nuke_everything
                ;;
            2)
                wipe_shell_history
                pause_prompt
                ;;
            3)
                wipe_browsers
                pause_prompt
                ;;
            4)
                wipe_dev_cache
                pause_prompt
                ;;
            5)
                wipe_session_tmp
                pause_prompt
                ;;
            6)
                echo -e "\n${CYAN}[*] Exiting session wiper...${NC}"
                sleep 0.5
                exit_routine
                ;;
            *)
                echo -e "\n${RED}[x] Invalid selection. Please choose a number between 1 and 6.${NC}"
                sleep 1.2
                ;;
        esac
    done
}

main "$@"
