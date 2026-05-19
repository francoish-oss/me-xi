{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    librewolf
  ];

  home.persistence."/persist" = {
    directories = [
      ".librewolf"
    ];
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

}
