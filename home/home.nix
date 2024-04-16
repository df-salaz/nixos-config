{ config, inputs, pkgs, ... }:

{
	imports = [
		./user
	];

	home.username = "koye";
	home.homeDirectory = "/home/koye";

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
		vlc
		dolphin-emu
		neo
		neovide
		obsidian
		mathematica
		krita
		blender
		prismlauncher
		gnome.gnome-calculator
		cinnamon.nemo
		rofimoji
		zoom-us
		gnome.nautilus
		neofetch
		firefox
		chromium
		waybar
		dunst
		wofi
		sway-contrib.grimshot
		pavucontrol
		swaylock-effects
		swayidle
	# AGS dependencies:
		libdbusmenu-gtk3
		libnotify
		bun
		fd
		dart-sass
		brightnessctl
		swww
		#inputs.matugen.packages.${system}.default
	# Optional AGS dependencies:
		hyprpicker
		slurp
		wf-recorder
		wl-clipboard
	];

	catppuccin.accent = "mauve";
	catppuccin.flavour = "mocha";
	xdg.enable = true;

	programs = {
		discocss.enable = true;
		ripgrep.enable = true;
		obs-studio.enable = true;
		zoxide = {
			enable = true;
			enableZshIntegration = true;
			options = [
				"--cmd cd"
			];
		};
		cava = {
			enable = true;
			settings = {
				color = {
					gradient = 1;
					gradient_count = 8;
					gradient_color_1 = "'#94e2d5'";
					gradient_color_2 = "'#89dceb'";
					gradient_color_3 = "'#74c7ec'";
					gradient_color_4 = "'#89b4fa'";
					gradient_color_5 = "'#cba6f7'";
					gradient_color_6 = "'#f5c2e7'";
					gradient_color_7 = "'#eba0ac'";
					gradient_color_8 = "'#f38ba8'";
				};
				input.method = "pipewire";
				smoothing.noise_reduction = 15;
			};
		};
		git = {
			enable = true;
			userEmail = "df.salaz@gmail.com";
			userName = "David";
		};
		eza = {
			enable = true;
			enableZshIntegration = true;
			icons = true;
		};
		foot = {
			enable = true;
			server.enable = false;
			settings = {
				main = {
					font = "JetBrainsMono Nerd Font:size=12";
					initial-window-size-chars = "90x24";
				};
				mouse = {
					hide-when-typing = "yes";
				};
				cursor = {
					color = "111111 cccccc";
				};
				colors = {
					foreground = "cdd6f4";
					background = "1e1e2e";
					regular0 = "45475a";
					regular1 = "f38ba8";
					regular2 = "a6e3a1";
					regular3 = "f9e2af";
					regular4 = "89b4fa";
					regular5 = "C4A0EE";
					regular6 = "94e2d5";
					regular7 = "bac2de";
					bright0 = "585b70";
					bright1 = "f38ba8";
					bright2 = "a6e3a1";
					bright3 = "f9e2af";
					bright4 = "89b4fa";
					bright5 = "C4A0EE";
					bright6 = "94e2d5";
					bright7 = "a6adc8";
					scrollback-indicator = "000000 98c379";
				};
			};
		};
		zathura = {
			enable = true;
			catppuccin.enable = true;
		};
		bat = {
			enable = true;
			catppuccin.enable = true;
			extraPackages = with pkgs.bat-extras; [ batman ];
		};
		btop = {
			enable = true;
			catppuccin.enable = true;
		};
		fzf = {
			enable = true;
			catppuccin.enable = true;
		};
		emacs = {
			enable = true;
		};
		zsh = {
			enable = true;
			shellAliases = {
				grep = "grep --color=auto";
				ip = "ip -color=auto";
				ll = "ls -l";
				la = "ll -a";
				c = "clear";
				vim = "${pkgs.neovide}/bin/neovide --no-fork &> /dev/null";
				svim = "sudo -E ${pkgs.neovide} --no-fork &> /dev/null";
				man = "${pkgs.bat-extras.batman}/bin/batman";
				jrun = "${pkgs.maven}/bin/mvn compile && mvn exec:java";
				jj = "javac *.java && java Main";
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

	services = {
		easyeffects.enable = true;
		cliphist.enable = true;
		udiskie.enable = true;
		udiskie.tray = "never";
	};

	gtk = {
		enable = true;
		catppuccin.enable = true;
		catppuccin.accent = "mauve";
		iconTheme = {
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};
		gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme = 1;'';
		gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme = 1;'';
	};
	qt = {
		enable = true;
		platformTheme = "gtk3";
	};

# Hyprland
	wayland.windowManager.hyprland = {
		enable = true;
		catppuccin.enable = true;
		settings = {
			monitor = "eDP-1, 1920x1080@60, 0x0, 1";
			"$terminal" = "${pkgs.foot}/bin/foot";
			"$lock" = "${pkgs.swaylock-effects}/bin/swaylock";
			"$mainMod" = "SUPER";
			"$calculator" = "${pkgs.gnome.gnome-calculator}/bin/gnome-calculator";
			"$power" = "ags -t powermenu";
			"$emoji" = "${pkgs.rofimoji}/bin/rofimoji --selector wofi";
			"$clipboard" = "${pkgs.wtype}/bin/wtype -- $(${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi -S dmenu -P Paste | ${pkgs.cliphist}/bin/cliphist decode)";
			"$runner" = "${pkgs.wofi}/bin/wofi -b -i -S run | xargs hyprctl dispatch exec --";
			"$menu" = "ags -t applauncher";
			"$screenshots" = "/home/koye/Pictures/Screenshots";
			"$ss-save" = "$screenshots/Screenshot-$(date '+%a-%b-%d-%T-%Z-%Y').png";
			"$ss" = "${pkgs.wl-clipboard}/bin/wl-copy < $(grimshot --notify save area $ss-save)";
			"$ss-wait" = "${pkgs.wl-clipboard}/bin/wl-copy < $(grimshot --notify --wait 5 save area $ss-save)";
			"$ss-screen" = "${pkgs.wl-clipboard}/bin/wl-copy < $(grimshot --notify save screen $ss-save)";
			exec-once = [
				"${pkgs.swayidle}/bin/swayidle"
					"${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"
					"ags"
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
					",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%- -n 1920"
					",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
					",XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"
					",XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"
					",XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"
					",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
					",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
					",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
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
			workspace = "special:scratchpad, on-created-empty:[float] ${pkgs.foot}/bin/foot -L sh -c '${pkgs.neofetch}/bin/neofetch && ${pkgs.zsh}/bin/zsh'";
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
