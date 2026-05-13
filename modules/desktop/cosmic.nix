{ config, lib, ... }:

{
  services.desktopManager.cosmic.enable = true;

  # If Impermanence add COSMIC Settings to persist
  environment.persistence."/persist" = lib.mkIf config.mySystem.impermanence.enable {
    hideMounts = true;
    directories = [
      "/var/lib/cosmic"
      ".config/cosmic"
    ];
  };

}
