# Frequently Asked Questions (FAQ)

### Does running wiper delete my bookmarks or saved browser passwords?
No. The Browser Wipe module is specifically designed as a targeted privacy cleaner. It removes browser caches, cookie files, navigation history, and session data, but explicitly avoids touching `Bookmarks`, `Login Data`, `Extensions`, or browser preference configurations.

### Do I need root/sudo to run the wiper?
No. All wiping operations run completely in user space without requiring root privileges. `sudo` is only optionally used if you choose to install the executable globally into `/usr/local/bin/wiper`.

### What does "Nuke Everything" do?
"Nuke Everything" executes all cleanup modules sequentially:
1. Shell history wipe (shreds history files and resets in-memory history).
2. Browser wipe (terminates browsers and purges caches/cookies/history).
3. Developer wipe (npm, Next.js build caches, Cursor, Windsurf).
4. Session & Tmp wipe (terminates SSH sessions, clears thumbnails and user /tmp files).
5. Closes the terminal window.

It prompts for confirmation (`[y/N]`) before executing.

### Can I run individual modules without closing my terminal?
Yes. Options 2 through 5 in the menu execute only that specific module and then prompt you to press Enter to return to the menu, keeping your terminal window open.

### How do I uninstall the tool?
Run the provided uninstaller script:
```bash
./uninstall.sh
```
Or manually delete `/usr/local/bin/wiper`.
