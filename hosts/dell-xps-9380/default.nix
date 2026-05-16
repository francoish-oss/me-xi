{ pkgs, ... }:
{
  imports = [
    ./disks.nix
    ./hardware-configuration.nix
    ./kernel-tpm2.nix
    ./bootloader.nix
    ./network.nix
    ./bluetooth.nix
  ];

  console = {
    font = "ter-132b";
    packages = [ pkgs.terminus_font ];
  };

  system.stateVersion = "25.11";
}
