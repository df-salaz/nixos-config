{ config, inputs, pkgs, ... }:

{
	imports = [
		./modules
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
	];

	catppuccin.accent = "mauve";
	catppuccin.flavour = "mocha";
	xdg.enable = true;

	programs = {
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
