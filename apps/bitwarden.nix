{
  pkgs,
  config,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    rbw
    pinentry-gnome3
  ];

  # Force the environment to ONLY see rbw
  home.sessionVariables = {
    SSH_AUTH_SOCK = "${config.home.sessionVariables.XDG_RUNTIME_DIR}/rbw/ssh-agent-socket";
    SSH_AUTH_ONLY = "yes";
  };

  programs.ssh = {
    enable = true;
    # This prevents Home Manager from trying to be "helpful" with other agents
    controlMaster = "no";

    extraConfig = ''
      Host *
        # Ensure we never look at ~/.ssh for keys
        IdentityFile /dev/null
        IdentitiesOnly yes
        # Trust the agent socket defined in sessionVariables
        IdentityAgent ${config.home.sessionVariables.XDG_RUNTIME_DIR}/rbw/ssh-agent-socket
    '';
  };

  # The "Clean Fix": Ensure rbw is the ONLY agent running
  systemd.user.services.rbw-agent = {
    Unit = {
      Description = "rbw ssh-agent wrapper";
      # Make sure it starts before you try to use SSH
      Before = [ "ssh-agent.service" ];
    };
    Service = {
      ExecStart = "${pkgs.rbw}/bin/rbw agent";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Persist only the rbw credentials/config
  home.persistence."/persist" = {
    allowOther = true;
    directories = [
      ".config/rbw"
    ];
  };
}
