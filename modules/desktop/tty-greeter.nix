{ ... }:

{
  programs.bash.loginShellInit = ''
    # If we are physically on TTY1 and COSMIC isn't running yet, launch it!
    if [ "$XDG_VTNR" = "1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
      exec start-cosmic
    fi
  '';
}
