{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    devpod
  ];
}
