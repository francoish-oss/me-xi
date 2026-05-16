{ pkgs, config, ... }:

let
  normalUsernames = builtins.attrNames (
    pkgs.lib.attrsets.filterAttrs (_: u: u.isNormalUser) config.users.users
  );

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

  security.sudo = {
    enable = true;
    extraRules = [
      {
        # 2. Grant the rule to all normal users dynamically
        users = normalUsernames;
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
