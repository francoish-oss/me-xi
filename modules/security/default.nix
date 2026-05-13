{ config, pkgs, inputs, ... }:

{
  imports = [
    ./firewall.nix
    ./root.nix
    ./sudo.nix
    ./impermanence.nix
    ./secureboot.nix
    ./bitwarden-ssh-agent.nix
  ];
}
