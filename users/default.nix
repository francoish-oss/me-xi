{ pkgs, username, ... }: {
  users.users."${username}" = {
    isNormalUser = true;
    description = "Primary User";
    extraGroups = [ "networkmanager" ];
    initialPassword = "123456";
  };
}
