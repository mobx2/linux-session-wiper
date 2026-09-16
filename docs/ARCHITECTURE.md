# Linux Session Wiper - Architecture

This document describes the design, execution flow, and safety boundaries of **Linux Session Wiper**.

## Architecture Overview

The tool is implemented as a standalone, POSIX-compatible Bash script (`session-cleanup.sh`) designed for user-space execution without requiring root privileges for its cleaning modules.

```
+---------------------------------------------------------------+
|                      User Invocation                          |
|             (wiper / ./session-cleanup.sh)                   |
+---------------------------------------------------------------+
                               |
                               v
+---------------------------------------------------------------+
|                    show_banner & show_menu                    |
|          ANSI Palette (Neon Green, Cyan, Magenta, Red)        |
+---------------------------------------------------------------+
                               |
               +---------------+---------------+
               |               |               |
               v               v               v
       +---------------+---------------+---------------+
       | Module 1      | Module 2      | Module 3      |
       | Shell History | Browser Wipe  | Dev Caches    |
       +---------------+---------------+---------------+
               |               |               |
               v               v               v
       +---------------+---------------+---------------+
       | Module 4      | Module 5      | Module 6      |
       | Session & Tmp | Nuclear Purge | Clean Exit    |
       +---------------+---------------+---------------+
```

## Modular Components

### 1. Shell History Module (`wipe_shell_history`)
- **In-Memory Buffer**: Cleared using `history -c` and truncated using `history -w /dev/null`.
- **Disk Storage**: Securely shreds or truncates `~/.bash_history` and `~/.zsh_history` using `shred -u -z -n 3` when available, followed by resetting file permissions to `600`.
- **Session Caches**: Purges `~/.bash_sessions` and `~/.sh_history`.

### 2. Browser Wipe Module (`wipe_browsers`)
- **Process Termination**: Gracefully kills active instances of Chrome, Brave, and Firefox via `pkill` to release SQLite WAL file locks and prevent in-memory data from flushing back to disk.
- **Cache Removal**: Deletes `~/.cache/google-chrome`, `~/.cache/BraveSoftware`, and `~/.cache/mozilla`.
- **Targeted SQLite Cleanup**: Targets `Cookies`, `History`, `Web Data`, and session store files within profile directories (`Default`, `Profile *`, `*.default*`) while strictly preserving bookmarks, saved passwords, and extensions.

### 3. Developer Cache Module (`wipe_dev_cache`)
- **Node.js / npm**: Clears npm cache using `npm cache clean --force` and removes `~/.npm`.
- **Next.js**: Depth-limited scan (up to 4 levels) in `$PWD` and `~/projects` for `.next/cache` directories.
- **Editor Caches**: Purges cache, GPUCache, CachedData, and log folders for Cursor and Windsurf editors.

### 4. Session & Tmp Module (`wipe_session_tmp`)
- **SSH Sessions**: Terminates active user SSH connections using `pkill -u "$USER" -x ssh`.
- **Thumbnails**: Clears `~/.cache/thumbnails/`.
- **User Tmp Files**: Deletes files and empty directories in `/tmp` strictly owned by `$USER`.

### 5. Exit Routine (`exit_routine`)
- Clears the terminal screen (`clear`).
- Sends `kill -HUP "$PPID"` to terminate the parent terminal emulator process cleanly.

## Error Handling Paradigm

Every file deletion and process signal suppresses standard error via `2>/dev/null || true` to guarantee idempotent, non-crashing execution regardless of whether an application is installed or active.
