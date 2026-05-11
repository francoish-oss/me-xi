{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/nix".neededForBoot = true;
}
