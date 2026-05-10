{ pkgs, ... }: {

  home.stateVersion = "25.11";

  imports = [
      ./modules/app/firefox.nix
  ];

  home.packages = with pkgs; [
    vlc
  ];

  programs.plasma = {
    enable = true;
  };

}
