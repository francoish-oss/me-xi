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

  home.file."/persist/.ssh/config.devpod" = {
    text = "# DevPod managed configurations\n";
  };

  programs.ssh = {
    extraConfig = ''
      Include ~/.ssh/config.devpod
    '';
  };

}
