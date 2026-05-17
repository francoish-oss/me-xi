# { config, pkgs, ... }:

# {
#   home.packages = with pkgs; [
#     mpv
#   ];
# }
{ config, pkgs, ... }:

let
  wrappedMpv = pkgs.writeShellScriptBin "mpv" ''
    exec ${pkgs.bubblewrap}/bin/bwrap \
      --ro-bind /nix /nix \
      --dev /dev \
      --proc /proc \
      --dir /tmp \
      --setenv XDG_RUNTIME_DIR "/run/user/$(id -u)" \
      --ro-bind /run/user/$(id -u)/pipewire-0 /run/user/$(id -u)/pipewire-0 \
      --ro-bind-try /run/user/$(id -u)/pulse /run/user/$(id -u)/pulse \
      --bind-try /run/user/$(id -u)/wayland-0 /run/user/$(id -u)/wayland-0 \
      --ro-bind-try /sys/dev/char /sys/dev/char \
      --ro-bind-try /sys/devices /sys/devices \
      --share-net \
      --bind "$HOME/Videos" "$HOME/Videos" \
      --bind "$HOME/Downloads" "$HOME/Downloads" \
      --unshare-all \
      ${pkgs.mpv}/bin/mpv "$@"
  '';
in
{
  home.packages = [
    wrappedMpv
  ];
}
