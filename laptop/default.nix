{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
