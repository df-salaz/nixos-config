{ pkgs, lib, ... }:
{
  systemd.services.numLockOnTty = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # /run/current-system/sw/bin/setleds -D +num < "$tty";
      ExecStart = lib.mkForce (pkgs.writeShellScript "numLockOnTty" ''
        for tty in /dev/tty{1..7}; do
        ${pkgs.kbd}/bin/setleds -D +num < "$tty";
        done
      '');
    };
  };
}
