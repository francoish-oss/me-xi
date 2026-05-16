{ pkgs, inputs, ... }:
{
  imports = [
    ../roles/admin/apps.nix
  ];

  users.users.fadmin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "updater"
    ];
    initialPassword = "123456";
  };

  home-manager.users.fadmin = {
    imports = [
      ../roles/admin/home.nix
    ];

    home.username = "fadmin";
    home.homeDirectory = "/home/fadmin";
    home.stateVersion = "25.11";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}
