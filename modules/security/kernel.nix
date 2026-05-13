{ pkgs, lib, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_hardened;

  boot.blacklistedKernelModules = [
    # Old/Obscure Networking (The "Ham Radio" stuff)
    "ax25"
    "netrom"
    "rose"
    "appletalk"
    "psnap"
    "p8022"
    "p8023"
    "can"

    # Ancient Filesystems (Security risks if you plug in a weird disk)
    "adfs"
    "affs"
    "befs"
    "bfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"

    # Legacy Hardware Ports
    "firewire-core" # DMA attack vector
    "floppy" # You definitely don't have a floppy drive
  ];
}
