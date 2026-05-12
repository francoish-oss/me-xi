{ config, lib, pkgs, inputs, ... }:

{

  # 1. Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  boot.plymouth.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
