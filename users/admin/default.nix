{ inputs, adminusername, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home.file."Desktop/MyFolder".source = /path/to/folder;

  users.users."${adminusername}" = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "123456";
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    users."${adminusername}" = {
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
        ".config/cosmic"
        ".local/share/cosmic"
        ".local/state/cosmic"
      ];
      files = [ ];
    };
  };

}
