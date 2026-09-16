# Automated Logout Cleanup with systemd

You can configure `wiper` to automatically run session cleanup when your user logs out or the system shuts down using systemd user units.

## Installation

1. Create the systemd user service directory if it does not exist:
   ```bash
   mkdir -p ~/.config/systemd/user
   ```

2. Copy the service unit:
   ```bash
   cp wiper-on-logout.service ~/.config/systemd/user/
   ```

3. Reload the systemd user daemon:
   ```bash
   systemctl --user daemon-reload
   ```

4. Enable and start the service:
   ```bash
   systemctl --user enable --now wiper-on-logout.service
   ```

## Verification

Check the service status:
```bash
systemctl --user status wiper-on-logout.service
```
