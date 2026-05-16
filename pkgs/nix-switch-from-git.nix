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

  users.groups.updater = { };

  # 2. Allow anyone in the 'updater' group to run ONLY this script
  security.sudo = {
    enable = true;
    extraRules = [
      {
        groups = [ "updater" ];
        commands = [
          {
            command = "${updateScript}/bin/nix-switch-from-git";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
