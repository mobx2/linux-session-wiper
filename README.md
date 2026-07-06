# Secure Session Cleanup Utility

A secure, user-space session cleanup utility designed for Debian/Ubuntu development environments. This script helps you quickly and safely close your workspace for privacy and maintenance reasons.

When executed, the `session-cleanup.sh` script will:
1. Clear the terminal screen and display a stylized aesthetic exit message.
2. Clear the active bash/zsh history for your user to maintain session privacy.
3. Gracefully terminate any of your active SSH connections or background network jobs.
4. Clean up temporary cache folders (such as `~/.cache/thumbnails` and your specific files in `/tmp`) used in the current session.
5. Safely close the terminal window.

The script is non-destructive and operates strictly within the current user space (no `sudo` or `root` commands are required or used).

## Installation

1. Clone or download this repository.
2. Make the script executable:

   ```bash
   chmod +x session-cleanup.sh
   ```

## Creating an Alias (`secure-exit`)

For the best experience, you should map this script to a global alias so you can quickly trigger it from any directory. 

Add the following line to your `~/.bashrc` or `~/.zshrc` configuration file:

```bash
# Secure exit alias
alias secure-exit='history -c && /absolute/path/to/session-cleanup.sh'
```

*Note: Replace `/absolute/path/to/session-cleanup.sh` with the actual absolute path to where you saved the script.*

After adding the alias, reload your shell configuration:

```bash
source ~/.bashrc
# or `source ~/.zshrc` if using zsh
```

## Usage

Simply type `secure-exit` in your terminal to trigger the cleanup and safely close your session window.
