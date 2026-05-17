{ pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    font = "${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSansMono.ttf";
    fontSize = 24;
  };
}
