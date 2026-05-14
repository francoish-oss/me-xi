{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rbw
    pinentry-gnome3 # Or pinentry-curses if you prefer
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
  };

  home.persistence."/persist" = {
    directories = [
      ".config/rbw"
    ];
  };
}
