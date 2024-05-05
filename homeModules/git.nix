{ lib, config, userSettings, ... }:
{
  options.git = {
    enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userEmail = userSettings.email;
      userName = userSettings.name;
    };
  };
}
