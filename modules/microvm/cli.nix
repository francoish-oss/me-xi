{ config, pkgs, username, lib, ... }:

{
  microvm.vms.my-dev-vm = {
    autostart = false;
    config = {
      networking.hostName = "micro-box";
      microvm.hypervisor = "cloud-hypervisor";
      services.getty.autologinUser = "root";
    };
  };

  # We use 'home-manager.users' here to keep the service tied to the user
  home-manager.users."${username}" = {
    systemd.user.services.microvm-session = {
      Unit.Description = "My Personal MicroVM Session";
      Install.WantedBy = [ "default.target" ];
      Service = {
        # Note: we use 'config' here because we are at the system level
        ExecStart = "${config.microvm.vms.my-dev-vm.config.microvm.runner}/bin/microvm-run";
        Restart = "on-failure";
      };
    };

    home.packages = [ pkgs.microvm ];
  };
}
