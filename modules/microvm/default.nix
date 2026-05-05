{ pkgs, ... }:

{
  # 1. Hardware/Hypervisor settings
  networking.hostName = "dev-vm";

  # 2. Enable Nix inside the VM so the user can work
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.dev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Let them sudo INSIDE the VM
    password = "dev";
  };

  # 4. Shared Folder (The "Portal")
  # This mounts a host folder into the VM
  microvm.shares = [ {
    source = "/home/user/projects/customer-a";
    mountPoint = "/home/dev/work";
    tag = "workdir";
    proto = "virtiofs";
  } ];
}
