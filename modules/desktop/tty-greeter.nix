{ ... }:

{
  programs.bash.loginShellInit = ''
    # Only run if we are on the first text terminal (login)
    # and a Wayland session isn't already running.
    if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
      exec start-cosmic
    fi
  '';
}
