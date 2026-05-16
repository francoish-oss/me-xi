{ ... }:

{
  environment.interactiveShellInit = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec start-cosmic
    fi
  '';
}
