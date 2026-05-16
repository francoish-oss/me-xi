{ pkgs, config, ... }:

let
  updateScript = pkgs.writeShellApplication {
    name = "nix-switch-from-git";
    runtimeInputs = [
      pkgs.sudo
      pkgs.nix
    ];
    text = ''
      echo "🔓 Unlocking /boot..."
      pkexec mount -o remount,rw /boot

      echo "❄️ Starting NixOS Rebuild..."
      pkexec nixos-rebuild switch --flake "github:francoish-oss/me-xi#dell-xps-9380" --refresh

      echo "🔒 Locking /boot..."
      pkexec mount -o remount,ro /boot

      echo "✅ Done! System is updated and /boot is secured."
      read -rp "Press enter to close..."
    '';
    # text = ''
    #   echo "🔓 Unlocking /boot..."
    #   sudo mount -o remount,rw /boot

    #   echo "❄️ Starting NixOS Rebuild..."
    #   sudo nixos-rebuild switch --flake "github:francoish-oss/me-xi#dell-xps-9380" --refresh

    #   echo "🔒 Locking /boot..."
    #   sudo mount -o remount,ro /boot

    #   echo "✅ Done! System is updated and /boot is secured."
    #   read -rp "Press enter to close..."
    # '';
  };
in
{
  # home.packages = [
  #   updateScript
  # ];
  environment.systemPackages = [ updateScript ];

  users.groups.nix-switch-from-git = { };

  security.sudo.extraRules = [
    {
      groups = [ "nix-switch-from-git" ];

      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }

        "/run/current-system/sw/bin/mount -o remount,rw /boot"

        "/run/current-system/sw/bin/mount -o remount,ro /boot"
      ];
    }
  ];
}
