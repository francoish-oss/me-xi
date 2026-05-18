{ config, pkgs, ... }:

{
  # Enable the NetBird client service
  services.netbird.clients.wt0 = {
    enable = true;

    # Set to true if you are on a desktop and want the Graphical UI
    ui.enable = false;

    # Automatically opens the necessary ports in the NixOS firewall
    openFirewall = true;
  };

  # Optional: For Netbird's mesh DNS resolution to work smoothly,
  # it is highly recommended to enable systemd-resolved
  services.resolved.enable = true;
}
