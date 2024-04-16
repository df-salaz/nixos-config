#!/bin/sh

case "$(echo -e "1 -  Shut down\n2 -  Reboot\n3 -  Log out" | wofi --sort-order=alphabetical --dmenu --insensitive --prompt "Power Menu" -H 190 -W 290)" in
	"1 -  Shut down") exec systemctl poweroff;;
	"2 -  Reboot") exec systemctl reboot;;
	"3 -  Log out") exec hyprctl dispatch exit;;
esac
