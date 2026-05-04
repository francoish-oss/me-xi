{ pkgs, adminusername, ... }: {
  users.users."${adminusername}" = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = [
      "networkmanager" # Control Wi-Fi/Internet
      "wheel"          # Enable sudo access
    ];
    initialPassword = "123456";
  };
}
