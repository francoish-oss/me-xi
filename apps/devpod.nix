{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    devpod
  ];

  home.persistence."/persist" = {
    directories = [
      ".devpod"
      ".config/devpod"
      ".local/share/devpod"
    ];
    files = [
      ".ssh/config.devpod"
    ];
  };

  programs.ssh = {
    extraConfig = ''
      Include ~/.ssh/config.devpod
    '';
  };

}
