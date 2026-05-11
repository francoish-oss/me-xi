{ device, ... }: {
  disko.devices = {
    disk = {
      main = {
        device = device;
        type = "disk";
        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Force override
                  subvolumes = {
                    # This is the one you will wipe/rollback
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    # This stores your Nix Store (needs to stay!)
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                      neededForBoot = true; # Somehow required ?
                    };
                    # This stores what you actually want to keep
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd" "noatime" ];
                      neededForBoot = true; # Somehow required ?
                    };
                    # Your swap file subvolume
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "12G";
                    };
                  };
                };
              };
            };


          };
        };
      };
    };
  };
}
