{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.zed-editor = {
    enable = true;
    package = inputs.zed-editor.packages.${pkgs.system}.zed-editor;
  };
}
