{ pkgs, ... }:
{
  # Packages specific to developers
  home.packages = with pkgs; [
    git
  ];

}
