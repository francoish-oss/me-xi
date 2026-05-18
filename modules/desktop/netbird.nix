{ config, pkgs, ... }:

{
  services.netbird.clients.wt0 = {
    hardened = true;
    port = 51820;
    ui.enable = true;
    # Automatically opens the necessary ports in the NixOS firewall
    openFirewall = true;
  };
}
