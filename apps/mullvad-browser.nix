{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    mullvad-browser
  ];

  home.persistence."/persist" = {
    directories = [
      ".mullvad"
    ];
  };
}
