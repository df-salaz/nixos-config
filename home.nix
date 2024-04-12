{ config, inputs, pkgs, ... }:

{
	imports = [ inputs.ags.homeManagerModules.default ];
	home.username = "koye";
	home.homeDirectory = "/home/koye";

	home.file = {
#		".config/hypr/hyprland.conf".source = config/hypr/hyprland.conf;
#		Causing issues -- will return to this
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.gnome.adwaita-icon-theme;
		name = "Adwaita";
		size = 16;
	};

	nixpkgs.config.allowUnfree = true;
	home.packages = with pkgs; [
		git
		ripgrep
		pulseaudio # for pactl
		playerctl
		mathematica
		krita
		blender
		prismlauncher
		cava
		gnome.gnome-calculator
		cinnamon.nemo
		rofimoji
		wf-recorder
		obs-studio
		zoom-us
		gnome.nautilus
		gradience
		btop
		neofetch
		firefox
		chromium
		neovide
		foot
		waybar
		dunst
		wofi
		swww
		hyprpicker
		slurp
		sway-contrib.grimshot
		wl-clipboard
		swappy
		easyeffects
		pavucontrol
		eza
		zoxide
		udiskie
		swaylock-effects
		swayidle
		bat
		bat-extras.batman
		zathura
	];

	programs = {
		emacs = {
			enable = true;
		};
		zsh = {
			enable = true;
			shellAliases = {
				ls = "eza --color=auto";
				grep = "grep --color=auto";
				ip = "ip -color=auto";
				ll = "ls -l";
				la = "ll -a";
				c = "clear";
				vim = "neovide --no-fork &> /dev/null";
				svim = "sudo -E neovide --no-fork &> /dev/null";
				man = "batman";
				jrun = "mvn compile && mvn exec:java";
				jj = "javac *.java && java Main";
# Nix likes to touch the .git directory as root :)
				nix-chown = "sudo chown -R koye ~/.nixos-config";
				nixr = "sudo nixos-rebuild switch --flake ~/.nixos-config && nix-chown";
				nixb = "sudo nixos-rebuild boot --flake ~/.nixos-config && nix-chown";
				nixu = "nix flake update ~/.nixos-config";
			};
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;
			autocd = true;
			initExtraFirst = ''
				source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
			'';
			initExtra = ''
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
[[ ! -f ~/.dotfiles/p10k.zsh ]] || source ~/.dotfiles/p10k.zsh
source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
PATH="$HOME/.emacs.d/bin:$PATH"
			'';
		};
		ags = {
			enable = true;
			extraPackages = with pkgs; [
				gtksourceview
				webkitgtk
				accountsservice
			];
		};
	};

	gtk = {
		enable = true;
		theme = {
			name = "adw-gtk3";
			package = pkgs.adw-gtk3;
		};
		iconTheme = {
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};
	};

	# Hyprland
	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			monitor = "eDP-1, 1920x1080@60, 0x0, 1";
			"$terminal" = "foot";
			"$lock" = "swaylock";
			"$mainMod" = "SUPER";
			"$calculator" = "gnome-calculator";
			"$power" = "ags -t powermenu";
			"$emoji" = "rofimoji --selector wofi";
			"$clipboard" = "wtype -- $(cliphist list | wofi -S dmenu -P Paste | cliphist decode)";
			"$runner" = "wofi -b -i -S run | xargs hyprctl dispatch exec --";
			"$menu" = "ags -t applauncher";
			"$screenshots" = "/home/koye/Pictures/Screenshots";
			"$ss-save" = "$screenshots/Screenshot-$(date '+%a-%b-%d-%T-%Z-%Y').png";
			"$ss" = "wl-copy < $(grimshot --notify save area $ss-save)";
			"$ss-wait" = "wl-copy < $(grimshot --notify --wait 5 save area $ss-save)";
			"$ss-screen" = "wl-copy < $(grimshot --notify save screen $ss-save)";
			exec-once = [
				"swayidle"
				"wl-paste --watch cliphist store"
				"~/.config/hypr"
				"ags"
				"easyeffects --gapplication-service"
				"udiskie"
			];
			input = {
				kb_layout = "us";
				numlock_by_default = true;
				follow_mouse = 1;
				float_switch_override_focus = 0;
				sensitivity = 0;
				accel_profile = "flat";
				touchpad = {
					natural_scroll = true;
					disable_while_typing = true;
				};
			};
			general = {
				layout = "dwindle";
				resize_on_border = true;
				allow_tearing = false;
			};
			animations = {
				first_launch_animation = false;
				bezier = "myBezier, 0.16, 1, 0.3, 1";
				animation = [
					"windows, 1, 3, myBezier"
					"windowsOut, 1, 7, myBezier, popin 80%"
					"border, 1, 2, default"
					"borderangle, 1, 8, default"
					"fade, 1, 3, myBezier"
					"workspaces, 1, 2, myBezier"
				];
			};
			dwindle = {
				no_gaps_when_only = true;
			};
			gestures = {
				workspace_swipe = true;
				workspace_swipe_min_speed_to_force = 5;
				workspace_swipe_direction_lock = false;
				workspace_swipe_forever = true;
			};
			misc = {
				disable_hyprland_logo = true;
				force_default_wallpaper = 0;
				vfr = true;
				disable_autoreload = true;
				swallow_regex = "^foot$";
				focus_on_activate = true;
				disable_splash_rendering = true;
				enable_swallow = true;
			};
			binds = {
				scroll_event_delay = 0;
			};
			debug = {
				overlay = false;
			};
			windowrule = [
				"noblur,^(?!(foot|neovide|swayimg)) # Only blur the terminal and Neovim"
				"windowdance,title:^(Rhythm Doctor)$"
				"forceinput,title:^(Rhythm Doctor)$"
			];
			windowrulev2 = [
				"float,class:^(org.gnome.Calculator)$"
				"suppressevent maximize, class:.*"
				"immediate, class:.*"
			];
			bind = [
				"$mainMod, tab, exec, ags -t overview"
				"$mainMod, return, exec, $terminal"
				"$mainMod, C, killactive,"
				"$mainMod, Q, exec, $calculator"
				"$mainMod, P, pin,"
				"$mainMod, F, fullscreen,"
				"$mainMod, G, fakefullscreen,"
				"$mainMod, M, exec, $lock"
				"$mainMod, E, exec, $power"
				"$mainMod, V, togglefloating, "
				"$mainMod, R, exec, $menu"
				"$mainMod, F2, exec, $runner"
				"$mainMod, comma, exec, $emoji"
				"$mainMod SHIFT, C, exec, hyprctl reload; ags -q; ags"
				"$mainMod SHIFT, S, exec, $ss"
				"$mainMod SHIFT, D, exec, $ss-wait"
				",XF86MonBrightnessDown, exec, brightnessctl set 5%- -n 1920"
				",XF86MonBrightnessUp, exec, brightnessctl set +5%"
				",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
				",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
				",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
				",XF86AudioPrev, exec, playerctl previous"
				",XF86AudioPlay, exec, playerctl play-pause"
				",XF86AudioNext, exec, playerctl next"
				"$mainMod, H, movefocus, l"
				"$mainMod, L, movefocus, r"
				"$mainMod, K, movefocus, u"
				"$mainMod, J, movefocus, d"
				"$mainMod, minus, togglespecialworkspace, scratchpad"
				"$mainMod SHIFT, minus, movetoworkspace, special:scratchpad"
				"$mainMod, mouse_up, workspace, e+1"
				"$mainMod, mouse_down, workspace, e-1"
				"$mainMod, right, workspace, e+1"
				"$mainMod, left, workspace, e-1"
			] ++ (
				builtins.concatLists (builtins.genList (
					x: let
						ws = let
						c = (x + 1) / 10;
						in
						builtins.toString (x + 1 - (c * 10));
					in [
						"$mainMod, ${ws}, workspace, ${toString (x + 1)}"
						"$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
					]
				)10)
			);
			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
			workspace = "special:scratchpad, on-created-empty:[float] foot -L sh -c 'neofetch && zsh'";
		};
	};
	
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "23.11"; # Please read the comment before changing.
}
