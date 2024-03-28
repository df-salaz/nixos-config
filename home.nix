{ config, pkgs, ... }:

{
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

#	home.packages = with pkgs; [
#		hello
#	];

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
				vim = "neovide --no-fork &> /dev/null";
				svim = "sudo -E neovide --no-fork &> /dev/null";
				man = "batman";
				jrun = "mvn compile && mvn exec:java";
# Nix likes to touch the .git directory as root :)
				nix-chown = "sudo chown -R koye ~/nixos-config";
				nixr = "sudo nixos-rebuild switch --flake ~/nixos-config && nix-chown";
				nixb = "sudo nixos-rebuild boot --flake ~/nixos-config && nix-chown";
				nixu = "nix flake update ~/nixos-config";
			};
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;
			autocd = true;
			initExtra = ''
				ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
				[[ ! -f ~/.dotfiles/p10k.zsh ]] || source ~/.dotfiles/p10k.zsh
				source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
			'';
		};
	};

	gtk = {
		enable = true;
		theme = {
			name = "adw-gtk3";
			package = pkgs.adw-gtk3;
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
