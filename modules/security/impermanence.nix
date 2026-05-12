{ config, pkgs, lib, ... }:

{
  # This configures the system-wide persistence
  environment.persistence."/persist" = {
    hideMounts = true;

    # SYSTEM DIRECTORIES (These live on your SSD)
    directories = [
      "/var/log"                 # Keeps system logs so you can troubleshoot crashes
      "/var/lib/bluetooth"       # Keeps your headphones/mouse paired
      "/var/lib/networkmanager"  # Keeps your Wi-Fi connections and passwords
      "/var/lib/nixos"           # Keeps track of system state/uid mappings

      # "/var/lib/nix"      # It's another partition separated from Root it's ok to remove it see /partition file from disko
    ];

    # SYSTEM FILES
    files = [
      "/etc/machine-id"          # This is unique to your hardware install
    ];
  };
}
