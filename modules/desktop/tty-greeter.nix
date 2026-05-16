{ ... }:

{
  programs.bash = {
    enable = true;
    profileExtra = "exec start-cosmic";
  };
}
