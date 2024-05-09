#!/bin/sh

case "$(echo -e "  Shut down
  Reboot
  Lock
⏼  Log out" | fuzzel -l 4 -w 20 -I -d)"
in
	"  Shut down") exec systemctl poweroff;;
	"  Reboot") exec systemctl reboot;;
	"  Lock") exec swaylock;;
	"⏼  Log out") exec sway exit;;
esac
