{ pkgs, ... }:

{
	programs.waybar = {
		enable = true;
		settings.mainBar = {
			layer = "top";
			position = "top";
			height = 30;
			spacing = 4;
			modules-left = [
				"power-profiles-daemon"
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
			tray = {
				spacing = 10;
				reverse-direction = true;
			};
			clock = {
				interval = 1;
				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
				format = "{:%m/%d/%Y | %I:%M:%S %p}";
			};
			backlight = {
				format = "{percent}% {icon}";
				format-icons = [
					""
					""
					""
					""
					""
					""
					""
					""
					""
				];
			};
			battery = {
				states = {
					warning = 30;
					critical = 15;
				};
				format = "{capacity}% {icon}";
				format-charging = "{capacity}% 󱐋";
				format-plugged = "{capacity}%  ";
				format-alt = "{icon}";
				format-full = "Full 󰣐 ";
				format-icons = [
					" "
					" "
					" "
					" "
					" "
				];
			};
			power-profiles-daemon = {
				format = "{icon}";
				tooltip-format = "Power profile: {profile}\nDriver: {driver}";
				tooltip = true;
				format-icons = {
					power-saver = "";
					balanced = "";
					performance = "";
				};
			};
			network = {
				format-wifi = "{essid} ({signalStrength}%)  ";
				format-ethernet = "{ipaddr}/{cidr} ";
				tooltip-format = "{ifname} via {gwaddr}";
				format-linked = "{ifname} (No IP) ";
				format-disconnected = "Disconnected ⚠";
				format-alt = "{ifname}: {ipaddr}/{cidr}";
			};
			pulseaudio = {
				ignored-sinks = [
					"Easy Effects Sink"
				];
				format = "{volume}% {icon} {format_source}";
				format-bluetooth = "{volume}% {icon} {format_source}";
				format-bluetooth-muted = "Muted 󰝟 {icon} {format_source}";
				format-muted = "Muted 󰝟 {format_source}";
				format-source = "{volume}% ";
				format-source-muted = "";
				format-icons = {
					headphone = "";
					headset = "󰋎";
					default = [
						""
						""
						""
					];
				};
				on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
			};
		};
		style = ../config/waybar/style.css;
	};
	services.dunst = {
		enable = true;
		settings = {
			global = {
				min_icon_size = 32;
				max_icon_size = 80;
				width = 300;
				height = 150;
				elipsize = "middle";
				vertical_alignment = "top";
				notification_limit = 5;
				follow = "none";
				origin = "top-right";
				offset = "8x8";
				progress_bar = true;
				icon_corner_radius = 4;
				indicate_hidden = "yes";
				padding = 8;
				frame_width = 2;
				separator_height = 1;
				gap_size = 0;
				sort = "yes";
				font = "JetBrainsMonoNerdFont 11";
				corner_radius = 8;
				mouse_left_click = "do_action, close_current";
				mouse_middle_click = "close_all";
				mouse_right_click = "close_current";
			};
		};
	};
}
