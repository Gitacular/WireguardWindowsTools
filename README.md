# WireguardWindowsTools
A set of Windows admin helpers for managing WireGuard on your system.

Welcome! These two files provide a Watchdog for your Windows or Windows Server WireGuard installation.

WireGuard itself delivers a stable client for automatically restarting and reconnecting after a Windows reboot. However, when you have dynamic DNS (common on home or mobile connections), your WireGuard connection can sometimes become inactive. This is normal because WireGuard is not designed for such scenarios, and that's where this tool comes in.

## What does WireguardWatchdog do?

1. **Checking Connection:** WireguardWatchdog monitors your connection from a Windows Server to, for example, an AVM FritzBox, to ensure it remains active.
2. **Reactivation:** If the connection becomes inactive (e.g., the network adapter disconnects), the script will automatically restore your configuration.
3. **Log Management:** When your log file reaches 100 MB, it will be automatically compressed.

## Prerequisites

- Windows 10 or higher | Windows Server 2016 or higher
- Administrative rights on your machine
- Installed WireGuard client
- Configured WireGuard client
- Knowledge of your custom paths if you've modified the defaults

## Files Included

You will receive and need two files:

- `InstallPlan.bat` – The Installation Script
- `WireguardWatchdog.ps1` – The Watchdog Script Template

## What does the Installation Script do?

- It prompts you to provide the paths and locations of your WireGuard installation on your system.
- It defines variables for the installation target and the WireGuard application location.
- It creates a scheduled task with system-level privileges for background functionality.
- Optionally, it can start the scheduled task for you with a brief pause at the end.
- The script uses `/` as the directory separator.

## What the Installation Script Does Not Do

- It does not install WireGuard itself.
- It does not configure any tunnel.
- It does not modify or delete any tunnel.
- It will not function correctly if you make changes that you are unfamiliar with.
- It does not include an uninstaller.

## Installation

To install, simply place both files in a location with access, and run `InstallPlan.bat`. If you don't have administrative rights, your session will be elevated. Otherwise, you can run it directly. After `InstallPlan.bat` completes, you can delete both files if you wish.

## Uninstallation

To uninstall the script, delete the `.ps1` and `.log` files from the installation folder, and then delete the associated scheduled task. That's all!
