{ lib, ... }:

{
	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				spacing = 4;
				modules-left = [
					"hyprland/workspaces"
					"hyprland/window"
				];
				modules-center = [
					"clock"
				];
				modules-right = [
					"pulseaudio"
					"network"
					"backlight"
					"battery"
					"tray"
				];
				"hyprland/workspaces" = {
					all-outputs = true;
					on-scroll-up = "hyprctl dispatch workspace e-1";
					on-scroll-down = "hyprctl dispatch workspace e+1";
				};
				mpd = {
					format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
					format-disconnected = "Disconnected ";
					format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
					unknown-tag = "N/A";
					interval = 2;
					consume-icons = {
						on = " ";
					};
					random-icons = {
						off = "<span color=\"#f53c3c\"></span> ";
						on = " ";
					};
					repeat-icons = {
						on = " ";
					};
					single-icons = {
						on = " " ;
					};
					state-icons = {
						paused = "";
						playing = "";
					};
					tooltip-format = "MPD (connected)";
					tooltip-format-disconnected = "MPD (disconnected)";
				};
			};
		};
		style = ../config/waybar/style.css;
	};
}
