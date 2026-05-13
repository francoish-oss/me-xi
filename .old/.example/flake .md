outputs = { self, nixpkgs, ... }@inputs: 
let
  # This is the "mkSystem" helper function
  mkSystem = name: system: extraModules: nixpkgs.lib.nixosSystem {
    inherit system;
    
    # This passes your flake inputs to EVERY module automatically
    specialArgs = { inherit inputs; }; 

    modules = [
      # 1. The specific hardware/config for this machine
      ./hosts/${name} 
      
      # 2. Global stuff every machine should have (e.g. core packages)
      ./modules/core.nix
      
      # 3. Any extra specific modules you passed in
    ] ++ extraModules;
  };
in {
  nixosConfigurations = {
    # Now defining a new machine is just ONE line!
    dell-xps-9380 = mkSystem "dell-xps-9380" "x86_64-linux" [ ./modules/desktop/cosmic.nix ];
    work-pc       = mkSystem "work-pc"       "x86_64-linux" [ ./modules/dev-tools.nix ];
    home-server   = mkSystem "home-server"   "aarch64-linux" [];
  };
};
