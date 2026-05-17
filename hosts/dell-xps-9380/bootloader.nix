{ ... }:
{
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.loader.systemd-boot.consoleMode = "1"; # 4k struggle with default
}
