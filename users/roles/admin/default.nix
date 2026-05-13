{ pkgs, ... }:
{
  imports = [
    ../../../pkgs/nix-switch-from-git.nix
  ];

  home.packages = with pkgs; [
  ];
}
