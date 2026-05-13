{ pkgs, ... }:

let
  # We define the script exactly as you have it
  updateScript = pkgs.writeShellApplication {
    name = "update-nixos";
    runtimeInputs = [
      pkgs.sudo
      pkgs.nix
    ];
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
  home.packages = [
    updateScript
  ];
}
