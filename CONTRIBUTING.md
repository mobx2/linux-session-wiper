# Contributing to Linux Session Wiper

Thank you for your interest in contributing to **Linux Session Wiper**! We welcome improvements, bug reports, and suggestions.

## Code of Conduct

Please be respectful, constructive, and considerate when opening issues and submitting pull requests.

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report, please check existing issues to see if the problem has already been documented.

When filing a bug report, include:
- Your Linux distribution and version (`uname -a`, `lsb_release -a`).
- Your default shell and version (`bash --version` or `zsh --version`).
- A clear description of the unexpected behavior and error messages.

### Suggesting Enhancements

We are always looking for ways to improve session cleanup and privacy coverage. When suggesting new wiper modules:
- Specify the target application (e.g., a specific browser, IDE, or CLI tool).
- Document cache and config paths across distributions.
- Ensure user safety (preserve critical user data like bookmarks, passwords, and config files).

### Pull Request Workflow

1. Fork the repository and clone your fork locally.
2. Create a feature branch from `main`:
   ```bash
   git checkout -b feat/your-feature-name
   ```
3. Implement your changes following our coding standards.
4. Test your script locally:
   ```bash
   bash -n session-cleanup.sh
   ```
5. Commit with conventional commit messages (e.g., `feat: ...`, `fix: ...`, `docs: ...`).
6. Push your branch to your fork and open a Pull Request against `main`.

## Scripting Guidelines

- **Bash standard**: Use standard Bash syntax compatible with Bash 4.x+.
- **Error suppression**: Suppress harmless stderr on removal commands (`2>/dev/null || true`).
- **No external heavy dependencies**: Keep the script lightweight with no mandatory dependencies beyond coreutils.
- **Safety first**: Never delete user configuration directories outright without explicit confirmation or targeted filtering.
