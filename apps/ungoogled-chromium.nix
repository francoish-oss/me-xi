{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    ungoogled-chromium
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/chromium"
    ];
  };
}
