{ inputs, adminusername, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users."${adminusername}" = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "123456";
  };

  home-manager = {
    backupFileExtension = "before-nix-reset";
    extraSpecialArgs = { inherit inputs adminusername; };
    users."${adminusername}" = {
      imports = [
        ./home.nix
      ];
    };
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    users."${adminusername}" = {
      directories = [
        "Documents"
        "Pictures"
        "Videos"
        ".config/cosmic"
        ".local/share/cosmic"
        ".local/state/cosmic"
        ".local/share/keyrings" # Need for wifi
      ];
      files = [
        ".config/cosmic-initial-setup-done"
      ];
    };
  };

}
