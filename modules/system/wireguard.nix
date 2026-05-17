{ pkgs, ... }:
{
  networking.networkmanager.enable = true;

  # Add the wireguard tools to your system packages so NetworkManager can invoke them
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.firewall = {
    enable = true;
    # CRITICAL: This stops NixOS from dropping WireGuard packets
    checkReversePath = false;

    # Optional: Open the standard WireGuard port if you host endpoints,
    # but it also helps client stability.
    allowedUDPPorts = [ 51820 ];
  };
}
