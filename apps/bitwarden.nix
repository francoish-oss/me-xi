{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    rbw
    pinentry-gnome3
  ];

  home.sessionVariables = {
    # We use the shell variable $XDG_RUNTIME_DIR here so it evaluates at runtime
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
    SSH_AUTH_ONLY = "yes";
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        # Hard-blindfold SSH from local files
        IdentityFile /dev/null
        IdentitiesOnly yes
        # Explicitly point to the rbw socket
        IdentityAgent /run/user/${toString config.home.uid}/rbw/ssh-agent-socket
    '';
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
    allowOther = true;
    directories = [
      ".config/rbw"
    ];
  };
}
