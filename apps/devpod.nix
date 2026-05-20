{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    devpod
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/devpod"
      ".local/share/devpod"
    ];
    files = [
      ".ssh/config.devpod"
    ];
  };

  home.file.".ssh/config.devpod".text = "";

  programs.ssh = {
    extraConfig = ''
      Include ~/.ssh/config.devpod
    '';
  };

}
