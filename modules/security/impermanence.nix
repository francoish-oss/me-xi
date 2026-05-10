{ config, pkgs, inputs, ... }:

{
  environment.persistence."/persist" = {
    hideMounts = true;

    # SYSTEM LEVEL PERSISTENCE
    # Even in a lean setup, these keep your hardware from "forgetting" its identity
    directories = [
      "/var/log"                 # For system logs/journal
      "/var/lib/bluetooth"       # Keeps your mouse/headphones paired
      "/var/lib/networkmanager"  # Keeps your Wi-Fi passwords
    ];

    files = [
      "/etc/machine-id"          # Crucial for DBus and system stability
    ];

    # USER LEVEL PERSISTENCE
    # Replace "your-username" with your actual user variable or string
    users.your-username = {
      directories = [
        "Documents"
        "Downloads"
        # Since you use Bitwarden and want a fresh browser,
        # we EXCLUDE .mozilla and .config/plasma files here.
      ];
      # Files you might want to keep in the home root
      files = [ ];
    };
  };
}
