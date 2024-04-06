# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
	system = "x86_64-linux";
in {
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
			inputs.home-manager.nixosModules.default
		];

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		mathematica
		catppuccin-sddm-corners
		libsForQt5.qt5.qtgraphicaleffects
		libsForQt5.qt5.qtquickcontrols2
		krita
		prismlauncher
		blender
		cava
		libdbusmenu-gtk3
		libnotify
		gnome.gnome-calculator
		cinnamon.nemo
		rofimoji
		wf-recorder
		bun
		dart-sass
		fd
		neo
		obsidian
		obs-studio
		zoom-us
		jdk8
		jdt-language-server
		lua-language-server
		nil
		rust-analyzer
		intel-compute-runtime
		intel-media-driver
		gnome.nautilus
		gradience
		btop
		neofetch
		firefox
		chromium
		git
		gh
		neovide
		foot
		waybar
		dunst
		wofi
		brightnessctl
		swww
		fzf
		hyprpicker
		slurp
		sway-contrib.grimshot
		wl-clipboard
		swappy
		easyeffects
		pavucontrol
		qogir-icon-theme
		gcc
		eza
		zoxide
		udiskie
		ntfs3g
		swaylock-effects
		swayidle
		killall
		bat
		bat-extras.batman
		texliveFull
		texlab
		zathura
		inputs.matugen.packages.${system}.default
	];

# Set filesystem options outside of hardware-configuration.nix
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/91f3764f-2fb8-4a89-86b1-cb8b89f7f9ab";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" ];
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/443F-918E";
      fsType = "vfat";
    };

# Bootloader.
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.loader.grub.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.grub = {
		efiSupport = true;
		useOSProber = true;
		device = "nodev";
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

# Set time and locale.
	time.timeZone = "America/Phoenix";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

# Enable the X11 windowing system.
	services.xserver.enable = true;

# Enable login manager
	services.xserver.displayManager.sddm = {
		enable = true;
#		wayland.enable = true;
		autoNumlock = true;
		theme = "catppuccin-sddm-corners";
	};
# services.xserver.desktopManager.gnome.enable = true;
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
	};

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
		settings.General.Experimental = true;
	};

# Enable touchpad support (enabled default in most desktopManager).
	services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users = {
		users.koye = {
			isNormalUser = true;
			description = "Koye";
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.zsh;
		};
		defaultUserShell = pkgs.zsh; # sets the root user's shell to zsh
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"koye" = import ./home.nix;
		};
	};

	environment.sessionVariables = {
# SDL_VIDEODRIVER = "x11"; # tf2
	};

# Add fonts.
	fonts.packages = with pkgs; [
		twitter-color-emoji
		noto-fonts
		noto-fonts-cjk
		liberation_ttf
		jetbrains-mono
		dejavu_fonts
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];
	fonts.fontDir.enable = true;
	fonts.enableDefaultPackages = true; 
	fonts.fontconfig = {
		defaultFonts = {
			monospace = [ "JetBrains Mono Nerd Font" ];
		};
	};

	qt.style = "adwaita";
	qt.platformTheme = "gnome";

# Swaylock is special.
	security.pam.services.swaylock = {};

	programs = {
		zsh = {
			enable = true;
			shellAliases = {
				ls = "eza --color=auto";
				grep = "grep --color=auto";
				ip = "ip -color=auto";
				ll = "ls -l";
				la = "ll -a";
				c = "clear";
				man = "batman";
			};
			syntaxHighlighting.enable = true;
			enableBashCompletion = true;
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
			viAlias = true;
		};
		steam = {
			enable = true;
			package = pkgs.steam.override {
				extraEnv = {
					SDL_VIDEODRIVER = "x11";
				};
			};
		};
		hyprland.enable = true;
		virt-manager.enable = true;
	};
	virtualisation.libvirtd.enable = true;

	zramSwap = {
		enable = true;
		memoryPercent = 150;
	};

# Enable services.
	services.openssh.enable = true;
	services.power-profiles-daemon.enable = true;
	services.upower.enable = true;
	services.dbus.implementation = "broker";
	services.udisks2.enable = true;
	security.polkit.enable = true;

	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
	};

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11";
}
