{ pkgs, username, ... }: {
  users.users."${username}" = {
    isNormalUser = true;
    description = "Primary User";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
