{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rbw
    pinentry-gnome3
  ];

  # This version is reusable for ANY user ID
  environment.extraInit = ''
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"
  '';
}
