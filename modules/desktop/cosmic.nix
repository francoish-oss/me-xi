{
  config,
  lib,
  options,
  ...
}:

{
  services.desktopManager.cosmic.enable = true;

  # If Impermanence add COSMIC Settings to persist
  environment.persistence."/persist" = lib.mkIf (options.environment ? persistence) {
    hideMounts = true;
    directories = [
      "/var/lib/cosmic"
      ".config/cosmic"
    ];
  };

}
