{ pkgs, config, ... }:
{
  imports = [
    ../../../modules/desktop/netbird.nix
    ../../../modules/desktop/flatpak.nix
  ];
}
