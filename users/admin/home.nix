{ lib, pkgs, ... }:

{
  home.stateVersion = "25.11"; # Note: Ensure this matches your actual HM version

  # Combine text and executable into ONE definition
  home.file."bin/update-nixos.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # 1. Remount /boot as Read-Write
      echo "🔓 Unlocking /boot..."
      sudo mount -o remount,rw /boot

      # 2. Run the NixOS Switch
      echo "❄️ Starting NixOS Rebuild..."
      sudo nixos-rebuild switch

      # 3. Remount /boot as Read-Only
      echo "🔒 Locking /boot..."
      sudo mount -o remount,ro /boot

      echo "✅ Done! System is updated and /boot is secured."
      read -p "Press enter to close..."
    '';
  };

  # The Desktop launcher
  home.file."Desktop/Update NixOS.desktop".text = ''
    [Desktop Entry]
    Name=Update NixOS
    Exec=bash ${config.home.homeDirectory}/bin/update-nixos.sh
    Type=Application
    Terminal=true
    Icon=system-run
  '';
}
