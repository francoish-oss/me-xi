{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    devpod
    devpod-desktop
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/devpod"
      ".local/share/devpod"
    ];
  };
}
