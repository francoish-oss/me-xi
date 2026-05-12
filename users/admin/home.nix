{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  # 1. Put the script in your home folder (or Desktop)
  home.file."bin/update-nixos.sh".text = ''
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

  home.activation.makeScriptExecutable = {
     text = ''
       chmod +x $HOME/bin/update-nixos.sh
     '';
   };

  # 2. Add a .desktop launcher on Desktop
  home.file."Desktop/Update NixOS.desktop".text = ''
    [Desktop Entry]
    Name=Update NixOS
    Exec=${pkgs.bash}/bin/bash $HOME/bin/update-nixos.sh
    Type=Application
    Terminal=true
    Icon=system-run
  '';
}
