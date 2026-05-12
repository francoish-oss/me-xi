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
      sudo nixos-rebuild switch --flake "github:francoish-oss/me-xi#dell-xps-9380" --refresh

      echo "🔒 Locking /boot..."
      sudo mount -o remount,ro /boot

      echo "✅ Done! System is updated and /boot is secured."
      read -rp "Press enter to close..."
    '';
  };
in
{
  home.stateVersion = "25.11";
  home.packages = [
    updateScript
    pkgs.vulnix
  ];
}
