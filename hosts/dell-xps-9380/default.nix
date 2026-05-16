{ ... }:
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
    enable = true;
    font = "latarcyrheb-sun32";
  };

  system.stateVersion = "25.11";
}
