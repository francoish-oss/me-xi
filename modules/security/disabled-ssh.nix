{ lib, ... }:

{
  # 1. Kill the default NixOS ssh-agent service
  programs.ssh.startAgent = false;

  # 2. Force SSH client configuration via environment variables
  environment.sessionVariables = {
    # This prevents ssh from trying to use a local file if the agent fails
    SSH_AUTH_ONLY = "yes";
  };

  # 3. System-wide SSH client settings to ignore default key locations
  programs.ssh.extraConfig = ''
    Host *
      # Prevents SSH from looking at ~/.ssh/id_rsa, id_ed25519, etc.
      IdentitiesOnly yes
      # Ensures it doesn't try to use a local agent if yours isn't set
      IdentityAgent none
  '';

  # 4. Disable user-level ssh-agent units if they exist (systemd)
  systemd.user.services."ssh-agent".enable = false;
}
