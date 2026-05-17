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

  # boot.loader.grub = {
  #   gfxmodeEfi = "1920x1080";
  #   gfxpayloadEfi = "keep";
  # };

  system.stateVersion = "25.11";
}
