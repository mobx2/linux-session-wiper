# Linux Session Wiper 

[![npm version](https://img.shields.io/npm/v/linux-session-wiper.svg?style=flat-square&color=cb3837)](https://www.npmjs.com/package/linux-session-wiper)
[![CI Status](https://img.shields.io/github/actions/workflow/status/mobx2/linux-session-wiper/lint.yml?branch=main&style=flat-square&label=CI)](https://github.com/mobx2/linux-session-wiper/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](./LICENSE)
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux-lightgrey.svg?style=flat-square)](https://www.kernel.org)

![Secure Exit Screenshot](./screen.png)

An advanced, interactive cyberpunk-styled terminal session and privacy cleaner for Linux. This utility allows developers and system administrators to quickly purge histories, browser cookies, developer caches, and temporary session files.

When executed, `session-cleanup.sh` provides an interactive menu with modular cleaning targets:
1. **Shell History Wipe**: Securely shreds `~/.bash_history` and `~/.zsh_history` and resets in-memory history.
2. **Browser Data Wipe**: Gracefully kills active browser instances (Chrome, Firefox, Brave) and purges caches, cookies, session storage, and SQLite history while preserving bookmarks and extensions.
3. **Developer Cache Wipe**: Cleans npm cache, project Next.js build caches (`.next/cache`), and Cursor / Windsurf editor caches and logs.
4. **Session & /tmp Wipe**: Terminates user SSH sessions, forcefully purges thumbnail cache (`~/.cache/thumbnails`), and cleans user-owned `/tmp` files.
5. **Nuke Everything**: Complete sequential execution of all modules with confirmation before closing the terminal window.

## Installation

### 1. Install via npm (Recommended)

Install globally using npm:

```bash
npm install -g linux-session-wiper
```

Once installed, run it anytime from any directory:

```bash
wiper
```

Or run instantly without installing via `npx`:

```bash
npx linux-session-wiper
```

---

### 2. Quick Install via Curl (System-Wide)

To install directly to `/usr/local/bin/wiper` without Node.js:

```bash
sudo curl -sL "https://raw.githubusercontent.com/mobx2/linux-session-wiper/refs/heads/main/session-cleanup.sh" -o /usr/local/bin/wiper && sudo chmod +x /usr/local/bin/wiper
```

Then run:

```bash
wiper
```

---

### 3. Manual Installation (from Source)

1. Clone this repository:
   ```bash
   git clone https://github.com/mobx2/linux-session-wiper.git
   cd linux-session-wiper
   ```
2. Make the script executable:
   ```bash
   chmod +x session-cleanup.sh
   ```
3. Execute directly:
   ```bash
   ./session-cleanup.sh
   ```

## Creating an Alias (`secure-exit`)

For quick access without system-wide installation, you can map the script to a shell alias.

Add the following line to your `~/.bashrc` or `~/.zshrc` configuration file:

```bash
# Secure exit alias
alias secure-exit='history -c && /absolute/path/to/session-cleanup.sh'
```

After adding the alias, reload your shell configuration:

```bash
source ~/.bashrc
# or `source ~/.zshrc` if using zsh
```

## Documentation

- [Architecture & Design](docs/ARCHITECTURE.md)
- [Frequently Asked Questions (FAQ)](docs/FAQ.md)
- [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
- [Automated Logout with systemd](systemd/README.md)
- [Contributing Guidelines](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)
- [Security Policy](SECURITY.md)

## License

This project is licensed under the [MIT License](LICENSE).
