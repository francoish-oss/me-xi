{ ... }:
{
  # Enable the hardware support, but...
  hardware.bluetooth.enable = true;

  # ...tell the system NOT to power it on automatically at boot.
  hardware.bluetooth.settings = {
    General = {
      AutoEnable = false;
    };
  };
}
