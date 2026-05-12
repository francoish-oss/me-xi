{ config, pkgs, inputs, ... }:

{
  imports = [
    ./admin.nix
  ];

  environment.system-packages = with pkgs; [
      sbctl
  ];
}
