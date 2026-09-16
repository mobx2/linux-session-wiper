# Security Policy

## Supported Versions

The latest commit on the `main` branch is actively supported and maintained with security and privacy patches.

| Version | Supported          |
| ------- | ------------------ |
| main    | Yes                |
| < 1.0   | No                 |

## Scope and Principles

Linux Session Wiper is designed to maintain terminal and workspace privacy:
- The script operates strictly within the running user space during cleanup operations.
- Destructive operations suppress stderr and use targeted path matching to prevent accidental removal of system files or personal user documents.
- No telemetry or outbound network connections are made by the cleanup script.

## Reporting a Vulnerability

If you discover a security vulnerability or an unintentional data loss issue:

1. **Do not open a public issue.**
2. Report the vulnerability privately to the maintainers by email or through GitHub Security Advisories.
3. Provide detailed information:
   - Operating system and distribution version.
   - Steps or commands to reproduce the issue.
   - The specific path or command causing unexpected behavior.
   - Potential impact.

We will acknowledge receipt within 48 hours and work on a fix promptly.
