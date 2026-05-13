{ pkgs, config, ... }:
{
  imports = [
    ../../../pkgs/nix-switch-from-git.nix
  ];

  home.packages = with pkgs; [
  ];

  home.persistence."/persist${config.home.homeDirectory}" = {
    hideMounts = true;
    users."${config.home.username}" = {
      directories = [
        "Documents"
        "Pictures"
        "Videos"
        ".config/cosmic"
        ".local/share/cosmic"
        ".local/state/cosmic"
        ".local/share/keyrings" # Need for wifi
      ];
      files = [
        ".config/cosmic-initial-setup-done"
      ];
    };
  };

}
