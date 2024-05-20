{ pkgs, ... }:
{
  users = {
    users.koye = {
      isNormalUser = true;
      description = "Koye";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
    defaultUserShell = pkgs.zsh; # sets the root user's shell to zsh
  };
}
