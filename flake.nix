{
  description = "Me-xi: Professional Modular NixOS Configuration";

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

    # 3. Community Modules
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";

    microvm.url = "github:microvm-nix/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      # The "Factory": Mixes core logic with host-specific ingredients
      mkHost =
        hostName:
        {
          hardwareModules ? [ ],
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostName; };
          modules = [
            # 1. The Host Entry Point (Imports hardware, users, and specific modules)
            ./hosts/${hostName}

            # 2. Global Modules (Things every machine gets)
            ./modules/security/secureboot.nix
            ./modules/security/impermanence.nix
            ./modules/security/restrict-sudo.nix
            ./modules/locales/english-azerty.nix

            # 3. Dynamic Inputs (External modules passed here)
            inputs.disko.nixosModules.disko
            inputs.impermanence.nixosModules.impermanence
            inputs.home-manager.nixosModules.home-manager
          ]
          ++ hardwareModules
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {

        "dell-xps-9380" = mkHost "dell-xps-9380" {
          hardwareModules = [
            inputs.nixos-hardware.nixosModules.dell-xps-13-9380
            inputs.lanzaboote.nixosModules.lanzaboote
          ];
          extraModules = [
            ./modules/desktop/cosmic.nix
            ./modules/desktop/cosmic-greeter.nix
            ./users/defs/f.nix
            ./users/defs/fadmin.nix
          ];
        };
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    };
}
