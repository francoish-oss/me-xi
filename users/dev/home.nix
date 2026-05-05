{ pkgs, ... }: {

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    firefox
    vlc
  ];

  programs.plasma = {
    enable = true;
  };

}
