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

  boot.loader.grub = {
    enable = true;
    gfxmodeBios = "1280x720";
  };

  system.stateVersion = "25.11";
}
