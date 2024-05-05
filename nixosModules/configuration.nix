# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
# Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.defaultPackages = [];
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    intel-compute-runtime
    intel-media-driver
    git
    gh
    gcc
    ntfs3g
    killall
  ];
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        grep = "grep --color=auto";
        ip = "ip -color=auto";
        ll = "ls -l";
        la = "ll -a";
        c = "clear";
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
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          SDL_VIDEODRIVER = "x11";
        };
      };
    };
    hyprland.enable = true;
    sway.enable = true;
    virt-manager.enable = true;
    tmux = {
      enable = true;
      shortcut = "b";
    };
    nano.enable = false;
  };
  virtualisation.libvirtd.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

# Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
#	services.xserver.enable = true;
#	services.xserver.excludePackages = [ pkgs.xterm ];

# Enable login manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
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
  security.pam.services.swaylock = {};

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

  systemd = {
    services.numLockOnTty = {
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
