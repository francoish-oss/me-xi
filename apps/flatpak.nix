{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    flatpak
  ];
}
