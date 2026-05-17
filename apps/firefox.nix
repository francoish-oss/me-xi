{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox;

    profiles.default = {
      isDefault = true;

      settings = {
        "browser.aboutConfig.showWarning" = false;
        "dom.security.https_only_mode" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.resistFingerprinting" = true;
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };
}
