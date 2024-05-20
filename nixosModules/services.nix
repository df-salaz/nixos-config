{
  services.openssh.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.dbus.implementation = "broker";
  services.udisks2.enable = true;
  services.printing.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
}
