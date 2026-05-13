{ pkgs, inputs, ... }:
{
  users.users.f = {
    isNormalUser = true;
    description = "Standard Developer User";
    extraGroups = [
      "networkmanager"
      "video"
    ];
    initialPassword = "123456";
  };

  home-manager.users.f = {
    imports = [
      ../roles/dev
    ];

    home.username = "f";
    home.homeDirectory = "/home/f";
    home.stateVersion = "25.11";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}
