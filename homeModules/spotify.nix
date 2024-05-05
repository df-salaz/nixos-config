{ pkgs, lib, config, ...}:
{
  options.spotify = {
    enable =
      lib.mkEnableOption "Enable Spotify (with adblock)";
  };

  config = lib.mkIf config.spotify.enable {
    home.packages = with pkgs; [
      nur.repos.nltch.spotify-adblock
    ];
  };
}
