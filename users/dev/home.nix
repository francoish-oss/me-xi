{ pkgs, ... }: {

  home.stateVersion = "25.11";

  imports = [
      ../../modules/apps/firefox.nix
      ../../modules/desktop/plasma-user-workspace.nix
  ];

  home.packages = with pkgs; [
    vlc
  ];

  programs.plasma = {
    enable = true;
  };

}
