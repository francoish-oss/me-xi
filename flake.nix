{
  description = "Me-xi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
        ./users
        ./modules/desktop/kde.nix
        ./modules/security
        nixos-hardware.nixosModules.dell-xps-13-9380
      ];
    };
  };
}
