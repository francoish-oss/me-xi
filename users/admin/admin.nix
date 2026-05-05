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
}
