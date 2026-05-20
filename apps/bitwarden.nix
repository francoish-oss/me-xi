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
      # Use full path to the binary to ensure it starts correctly
      ExecStart = "${pkgs.rbw}/bin/rbw agent";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.persistence."/persist" = {
    directories = [
      ".config/rbw"
      ".local/share/rbw"
    ];
  };
}
