{
  description = "Me-xi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.dell-xps-9380-13-4k = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        username = "f";
      };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./i18n/i18n.nix
        ./users # This automatically looks for ./users/default.nix
      ];
    };
  };
}
