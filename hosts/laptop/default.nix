{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "laptop";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
