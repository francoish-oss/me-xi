{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware/dell-xps-9380/hardware-configuration.nix ];

  # 1. Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
