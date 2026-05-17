{ pkgs, config, ... }:
{
  imports = [
    ../../../modules/desktop/tailscale.nix
  ];
}
