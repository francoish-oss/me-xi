# me-xi
My first take at Nix

Aim :
- Having a personal NixOs configuration to bring peace of mind & security in a non massive enterprise environment.

This os configuration is splited in two account :
- User (where you only work)
- Admin (where you only configure the nixos)

And it's splited in two way :
- CLI VM -> Install random cli tool / software 
- DEV VM -> Work on one project per VM.
- DEV GUI VM -> Work on one project per VM that require Wayland forwarding (Tauri Electron Qt work...).

Acknoledges weakness for QOL :
- Clipboard Poisoning: A vm could potentially read/reach the clipboard of host
- The host can scan local network (printer...)
- The pc will have one sudo user to avoid os lock out (while there is other strategy it's the simpliest fearless one, for someone who want a NixOs for themselves not to distribute across multiple pc)

The Host configuration should :
- **Have** Kernel LockDown
- **Have** Kernel Hardened
- **Have** Secure Boot
- **Have** USBGuard
- **Have** Socket Only SSH + Imuable .ssh folder
- **Have** An impermanence configuration
- [On Public Wifi] **Have** Mac Address randomization
- **Have** Mullwad DNS Setup
- **Have** Wayland 'Idle-Inhibit' Blocking
- **Have** Systemd-oomd configuration
- **Have** updateMicrocode
- **Have** nix auto-optimise-store
- **Have** networking stevenblack enabled (Unified hosts + fakenews)
- **Have** nix garbage collection automatic
- **Have** hardware bluetooth powerOnOnBoot disabled
- **Have** security.sudo.execWheelOnly
- **Have** Location Provider Manual
- Disabled touchpad while typing
- AppStream disabled
- Min Free 512Mo

The VM configuration should :
- **Have** Agent SSH Forwarding & Imuable .ssh folder

The user should : 
- **NEVER** Generate any .ssh key in .ssh folder, always through an ssh agent
- **NEVER** Have access to a terminal
- **NEVER** Have access to su / sudo ... or be sudo or sudo binary
- **NEVER** Have access to Nix binaries
- **NEVER** Have exec permission on /home & /tmp

The admin account should :
- **have** auditd
- **have** fwupd

Apps :
- **Firefox** + **UblockOrigin**
- **Chromium**
- **VLC**
- **Capcut**
- **Gimp**
- **Zed**
- **Git**
- **Bitwarden**
- **Bitwarden SSH Agent**
- **Mullwad**
