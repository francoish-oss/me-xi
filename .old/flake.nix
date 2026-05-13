{
  description = "Me-xi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm.url = "github:microvm-nix/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware, lanzaboote, home-manager, microvm, impermanence, disko, ... }@inputs: {
    nixosConfigurations.dell-xps-9380 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        username = "f";
        adminusername = "fadmin";
        device = "/dev/nvme0n1";
      };
      modules = [
        nixos-hardware.nixosModules.dell-xps-13-9380
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        lanzaboote.nixosModules.lanzaboote

        # 1. Hardware & System Core
        ./configuration.nix
        ./hardware/dell-xps-9380/hardware-configuration.nix
        ./hardware/fs_needforboot.nix
        ./partition.nix
        ./i18n/english_azerty.nix

        # 2. Users
        ./users/admin
        ./users/dev

        # 3. System
        ./modules/desktop/cosmic.nix
        ./modules/security

        # 4. Theme (bc why not)
        # TODO
      ];
    };



  }; # END OF OUTPUT
}
