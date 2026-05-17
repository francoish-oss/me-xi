{ pkgs, inputs, ... }:
{
  imports = [
    ../roles/dev/apps.nix
  ];

  services.flatpak.enable = true;

  users.users.f = {
    isNormalUser = true;
    description = "Standard Developer User";
    extraGroups = [
      "networkmanager"
      "video"
      "nix-switch-from-git"
    ];
    initialPassword = "123456";
  };

  home-manager.users.f = {
    imports = [
      ../roles/dev/home.nix
    ];

    home.username = "f";
    home.homeDirectory = "/home/f";
    home.stateVersion = "25.11";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}
