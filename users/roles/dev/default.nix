{ pkgs, config, ... }:
{
  # Packages specific to developers
  home.packages = with pkgs; [
    git
  ];

  environment.persistence."/persist" = {
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
