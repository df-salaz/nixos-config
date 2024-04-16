{ config, inputs, pkgs, ... }:

{
	programs = {
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
		zoxide = {
			enable = true;
			enableZshIntegration = true;
			options = [
				"--cmd cd"
			];
		};
		eza = {
			enable = true;
			enableZshIntegration = true;
			icons = true;
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
			initExtraFirst = ''source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh'';
			initExtra = ''ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
[[ ! -f ~/.dotfiles/p10k.zsh ]] || source ~/.dotfiles/p10k.zsh
source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
PATH="$HOME/.emacs.d/bin:$PATH"'';
		};
	};
}
