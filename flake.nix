{
  description = "Me-xi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.dell-xps-9380-13-4k = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        username = "f";
        adminusername = "fadmin";
      };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./i18n/i18n.nix
        ./users/admin.nix
        ./modules/desktop/kde.nix
        nixos-hardware.nixosModules.dell-xps-13-9380
      ];
    };
  };
}
