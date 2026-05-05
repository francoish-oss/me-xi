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

    stylix.url = "github:nix-community/stylix";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations.dell-xps-9380 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        username = "f";
        adminusername = "fadmin";
      };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./i18n/english_azerty.nix
        ./users/admin
        ./users/dev
        ./modules/desktop/kde.nix
        ./modules/security
        nixos-hardware.nixosModules.dell-xps-13-9380
      ];
    };
  };
}
