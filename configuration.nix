{ config, lib, pkgs, inputs, ... }: # Added 'inputs' here so it can see your flake inputs

{
  imports = [ ./hardware-configuration.nix ];

  # 1. Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.f = {
    isNormalUser = true;
    description = "f";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
