{ pkgs, ... }: {
  security.sudo.enable = true;
  security.sudo.execWheelOnly = true;

  # Restrict the 'su' command to wheel group only
  security.pam.services.su.requireWheel = true;
}
