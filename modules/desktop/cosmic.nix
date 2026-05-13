{ config, lib, ... }:

{
  services.desktopManager.cosmic.enable = true;

  # If Impermanence add COSMIC Settings to persist
  environment.persistence."/persist" =
    lib.mkIf (lib.hasAttr "/persist" config.environment.persistence)
      {
        hideMounts = true;
        directories = [
          "/var/lib/cosmic"
          ".config/cosmic"
        ];
      };

}
