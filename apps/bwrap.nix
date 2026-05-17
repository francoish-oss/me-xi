{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    bubblewrap
  ];
}
