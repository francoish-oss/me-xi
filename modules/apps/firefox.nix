{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    # Configure the default profile
    profiles.default = {
      isDefault = true;

      # 1. Extensions (uBlock Origin)
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];

      # 2. Brave Search as Default
      search = {
        force = true;
        default = "Brave";
        engines = {
          "Brave" = {
            urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://search.brave.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@b" ];
          };
        };
      };
    };
  };

  # 3. Plasma Desktop Icon
  programs.plasma.desktop.icons = [
    {
      name = "Firefox";
      icon = "firefox";
      # This points to the .desktop file provided by the firefox package
      link = "${pkgs.firefox}/share/applications/firefox.desktop";
      x = 0;
      y = 0;
    }
  ];
}
