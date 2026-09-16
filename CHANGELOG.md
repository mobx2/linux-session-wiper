# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-09-17

### Added
- Interactive numeric menu using standard bash read and case statements.
- Retro cyberpunk ASCII art banner with Neon Green, Cyan, and Red ANSI colors.
- Modular wiping targets:
  - Shell history wipe (Bash & Zsh secure reset with shredding).
  - Browser privacy purge (Chrome, Brave, Firefox caches, cookies, session state).
  - Developer cache cleanup (npm, Next.js build caches, Cursor, Windsurf).
  - System session cleanup (SSH sessions, thumbnail cache, user /tmp files).
  - Nuclear wipe option with confirmation prompt.
- Global installation one-liner via curl to `/usr/local/bin/wiper`.
- Systemd user service unit for automatic logout execution.
- Shell completion scripts for Bash and Zsh.
- Automated uninstaller script (`uninstall.sh`).
- GitHub Actions CI workflow for ShellCheck and syntax validation.

### Fixed
- Quoted array expansions and unused variables identified by ShellCheck.
- Handled EOF and Ctrl+D gracefully in terminal interactive menus.

## [1.0.0] - 2026-09-16

### Added
- Initial release: basic session-cleanup script for clearing history and closing sessions.
