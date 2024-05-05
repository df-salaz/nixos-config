{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
