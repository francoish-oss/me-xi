{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cosmic-ext-applet-minimon
  ];
}
