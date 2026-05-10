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
    backupFileExtension = "before-nix-reset";
    extraSpecialArgs = { inherit inputs username; };
    users."${username}" = {
      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
        ./home.nix
      ];
    };
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    users."${username}" = {
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
      files = [ ];
    };
  };

}
