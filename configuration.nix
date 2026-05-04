{ config, lib, pkgs, inputs, ... }: # Added 'inputs' here so it can see your flake inputs

{
  imports = [ ./hardware-configuration.nix ];

  # 1. Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  system.stateVersion = "25.11";
}
