{ config, pkgs, inputs, ... }:

{
  imports = [
    ./firewall.nix
    ./root.nix
    ./sudo.nix
    ./impermanence.nix
  ];
}
