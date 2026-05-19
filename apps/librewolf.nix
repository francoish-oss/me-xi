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
}
