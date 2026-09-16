# Troubleshooting Guide

This guide addresses common questions and troubleshooting scenarios when using **Linux Session Wiper**.

## Common Scenarios

### 1. Terminal does not close after exit routine
- **Cause**: Some terminal multiplexers (such as `tmux` or `screen`) or virtual shells intercept the `SIGHUP` signal sent to `$PPID`.
- **Solution**: The exit routine sends `kill -HUP "$PPID" 2>/dev/null || exit 0`. If using tmux, close the window with `exit` or `Ctrl+D` after wiper finishes.

### 2. Browser history still appears after wipe
- **Cause**: The browser was still active in memory and rewrote its SQLite database files to disk upon shutdown.
- **Solution**: Ensure you run the Browser Wipe module, which automatically terminates browser processes before deleting SQLite cookie/history databases.

### 3. Permission denied errors when cleaning /tmp
- **Cause**: Files in `/tmp` created by root or other system users cannot be deleted by an unprivileged user.
- **Solution**: Linux Session Wiper explicitly filters temporary files with `-user "$USER"`, cleaning only files owned by you. System files are deliberately untouched.

### 4. Global `wiper` command not found
- **Cause**: `/usr/local/bin` is not included in your `$PATH`, or the script was not made executable.
- **Solution**:
  1. Check permissions: `ls -l /usr/local/bin/wiper` (should show `rwxr-xr-x`).
  2. Verify your `$PATH` contains `/usr/local/bin`: `echo "$PATH"`.

### 5. SSH connection severed during Session Wipe
- **Cause**: The Session & /tmp wipe module terminates active SSH processes (`pkill -u "$USER" -x ssh`). If you are connected to the machine remotely via an SSH client session owned by the same user, this will terminate the session.
- **Solution**: When managing a remote server, run individual modules (History, Browser, Dev cache) instead of Session Wipe or Nuke Everything.
