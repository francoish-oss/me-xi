{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    rbw
    pinentry-gnome3
  ];

  # Need the doublon to overwrite the gnome keyring
  systemd.user.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
    SSH_AUTH_ONLY = "yes";
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
    SSH_AUTH_ONLY = "yes";
    SSH_ASKPASS_REQUIRE = "force";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # make $XDG_RUNTIME_DIR resolves correctly
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"
    '';
  };

  programs.bash.interactiveShellInit = ''
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"
  '';

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = "\${XDG_RUNTIME_DIR}/rbw/ssh-agent-socket";
        };
      };
    };

  };

  systemd.user.services.rbw-agent = {
    Unit = {
      Description = "rbw ssh-agent wrapper";
    };
    Service = {
      ExecStart = "${pkgs.rbw}/bin/rbw agent";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.persistence."/persist" = {
    # share/rbw/device_id & .config/rbw/config.json
    directories = [
      ".config/rbw"
      ".local/share/rbw"
    ];
  };
}
