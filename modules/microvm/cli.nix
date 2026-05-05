{ config, pkgs, inputs, username, ... }: {

  # 1. NIXOS LEVEL: Define the VM
  # This works because microvm.nixosModules.host is in flake.nix
  microvm.vms.my-dev-vm = {
    autostart = false;
    config = {
      networking.hostName = "micro-box";
      microvm.hypervisor = "cloud-hypervisor";
      services.getty.autologinUser = "root";
    };
  };

  # 2. HOME-MANAGER LEVEL: The User Service
  home-manager.users."${username}" = {
    systemd.user.services.microvm-session = {
      Unit.Description = "My Personal MicroVM Session";
      Install.WantedBy = [ "default.target" ];
      Service = {
        # Access the system config to get the generated runner path
        ExecStart = "${config.microvm.vms.my-dev-vm.package}/bin/microvm-run";
        Restart = "on-failure";
      };
    };

    # FIX: Don't use pkgs.microvm (it doesn't exist). Use the flake input:
    home.packages = [
      inputs.microvm.packages.${pkgs.system}.default
    ];
  };
}
