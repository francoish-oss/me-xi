{ pkgs, adminusername, ... }: {
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
    users."${username}" = {
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
      files = [ ];
    };
  };

}
