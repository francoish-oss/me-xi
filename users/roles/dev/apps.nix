{ pkgs, config, ... }:
{
  imports = [
    ../../../modules/desktop/tailscale.nix
    ../../../modules/desktop/flatpak.nix
  ];
}
