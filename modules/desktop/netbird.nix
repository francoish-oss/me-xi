{ config, pkgs, ... }:

{
  services.netbird.clients.passac = {
    hardened = true;
    port = 51820;
    ui.enable = true;
    # Automatically opens the necessary ports in the NixOS firewall
    openFirewall = true;
    user.group = "netbird-passac";
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/netbird-passac"
    ];
  };

}
