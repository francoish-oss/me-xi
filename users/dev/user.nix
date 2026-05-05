{ pkgs, inputs, username, ... }: {

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users."${username}" = {
    isNormalUser = true;
    description = "Primary User";
    extraGroups = [ "networkmanager" ];
    initialPassword = "123456";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username; };
    users."${username}" = {
      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
        ./home.nix
      ];
    };
  };
}
