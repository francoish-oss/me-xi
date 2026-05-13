{ pkgs, config, ... }:

{


  programs.ssh = {
    enable = true;

    # tell SSH where to put files instead of letting it guess (and fail) at ~/.ssh
    controlMaster = "auto";
    controlPath = "$XDG_RUNTIME_DIR/ssh-%u-%h:%p";

    extraConfig = ''
      # 2. THE LOCKDOWN:
      # Tell SSH to ignore ALL default keys in ~/.ssh
      # It will ONLY use keys provided by the Bitwarden Agent
      IdentitiesOnly yes
      IdentityFile /dev/null

      # 3. NATIVE REDIRECT:
      # Use the XDG standard for known_hosts
      UserKnownHostsFile ${config.home.homeDirectory}/.cache/ssh/known_hosts
    '';
  };
}
