{
  description = "Me-xi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    microvm.url = "github:microvm-nix/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
  };

  outputs = { self, nixpkgs, nixos-hardware, microvm, ... }@inputs: {
    nixosConfigurations.dell-xps-9380 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        username = "f";
        adminusername = "fadmin";
      };
      modules = [
        # 1. Hardware & System Core
        ./configuration.nix
        ./hardware-configuration.nix
        ./i18n/english_azerty.nix
        nixos-hardware.nixosModules.dell-xps-13-9380

        # 2. Users
        ./users/admin
        ./users/dev

        # 3. System
        ./modules/desktop/kde.nix
        ./modules/security

        # 4. Theme (bc why not)
        # TODO
      ];
    };
  };
}
