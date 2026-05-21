{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  home.persistence."/persist" = {
    files = [
      ".gitconfig"
    ];
  };
}
