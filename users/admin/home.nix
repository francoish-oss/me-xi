{ lib, pkgs, config, ... }:

let
  # This creates a "package" out of your script
  updateScript = pkgs.writeShellApplication {
    name = "update-nixos"; # The command will be 'update-nixos'
    runtimeInputs = [ pkgs.sudo pkgs.nix ]; # Tools the script needs
    text = ''
      echo "🔓 Unlocking /boot..."
      sudo mount -o remount,rw /boot

      echo "❄️ Starting NixOS Rebuild..."
      sudo nixos-rebuild switch

      echo "🔒 Locking /boot..."
      sudo mount -o remount,ro /boot

      echo "✅ Done! System is updated and /boot is secured."
      read -p "Press enter to close..."
    '';
  };
in
{
  home.stateVersion = "25.11";

  # 1. Add the script package to your user profile
  home.packages = [ updateScript ];

  # 2. Update the .desktop launcher to use the package path
  home.file."Desktop/Update NixOS.desktop".text = ''
    [Desktop Entry]
    Name=Update NixOS
    Exec=${lib.getExe updateScript}
    Type=Application
    Terminal=true
    Icon=system-run
  '';
}
