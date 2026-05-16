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

  boot.loader.grub = {
    enable = true;

    # Higher resolution but still readable
    gfxmodeEfi = "1920x1080";

    # Optional: use same resolution for boot splash
    gfxpayloadEfi = "keep";
  };

  system.stateVersion = "25.11";
}
