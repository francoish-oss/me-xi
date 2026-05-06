# { config, pkgs, inputs, username, ... }: {

#   # 1. Define the VM at the NixOS level
#   microvm.vms.my-dev-vm = {
#     autostart = false;
#     config = {
#       networking.hostName = "micro-box";
#       microvm.hypervisor = "cloud-hypervisor";
#       services.getty.autologinUser = "root";
#     };
#   };

#   # 2. User-level Systemd Service
#   home-manager.users."${username}" = {
#     systemd.user.services.microvm-session = {
#       Unit = {
#         Description = "My Personal MicroVM Session";
#         # Ensure it starts after the graphical session if needed
#         After = [ "graphical-session.target" ];
#       };
#       Install.WantedBy = [ "default.target" ];
#       Service = {
#         # This path is automatically handled by the NixOS microvm module
#         ExecStart = "${config.microvm.vms.my-dev-vm.run}/bin/microvm-run";
#         Restart = "on-failure";
#       };
#     };

#     # Only add this if you want the 'microvm' command available in your shell
#     # Use the correct attribute name 'microvm' instead of 'default'
#     home.packages = [
#       inputs.microvm.packages.${pkgs.system}.microvm
#     ];
#   };
# }

{ config, pkgs, inputs, ... }: {

  # HOST IMPORT: Tells your Dell XPS HOW to run VMs
  imports = [
    inputs.microvm.nixosModules.host
  ];

  microvm.vms.cli-vm = {
    config = {
      # GUEST IMPORT: Tells the VM it IS a VM
      imports = [ inputs.microvm.nixosModules.microvm ];

      microvm.hypervisor = "firecracker";
      networking.hostName = "private-guest";

    };
  };
}
