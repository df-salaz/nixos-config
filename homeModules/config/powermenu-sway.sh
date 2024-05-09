#!/bin/sh

case "$(echo -e "  Shut down
  Reboot
  Lock
⏼  Log out" | fuzzel -l 4 -w 20 -I -d --index)"
in
	"0") exec systemctl poweroff;;
	"1") exec systemctl reboot;;
	"2") exec swaylock;;
	"3") exec sway exit;;
esac
