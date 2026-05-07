{ inputs, username, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/microvm/cli.nix
  ];

  users.users."${username}" = {
    isNormalUser = true;
    description = "Primary User";
    extraGroups = [ "networkmanager" "kvm" "libvirtd"];
    initialPassword = "123456";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs username; };
    users."${username}" = {
      imports = [
        inputs.plasma-manager.homeManagerModule.plasma-manager
        ./home.nix
      ];
    };
  };



}
