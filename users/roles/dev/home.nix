{ pkgs, config, ... }:
{
  imports = [
    ../../../apps/bitwarden.nix
    ../../../apps/bwrap.nix
    ../../../apps/firefox.nix
  ];

  # Packages specific to developers
  home.packages = with pkgs; [
  ];

  home.persistence."/persist" = {
    hideMounts = true;
    # users."${config.home.username}" = {
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
    # };
  };

}
