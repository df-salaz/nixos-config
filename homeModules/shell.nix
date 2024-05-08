{ config, inputs, lib, userSettings, pkgs, ... }:

{
  options.shell = {
    enable =
      lib.mkEnableOption "Enable shell configuration";
  };

  config = lib.mkIf config.shell.enable {
    programs = {
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
        extraPackages = with pkgs.bat-extras; [ batman ];
      };
      btop = {
        enable = true;
      };
      fzf = {
        enable = true;
      };
      zsh = {
        enable = true;
        shellAliases = {
          grep = "grep --color=auto";
          ip = "ip -color=auto";
          la = "ls -a";
          ll = "la -l";
          c = "clear";
          svim = "sudoedit";
          man = "${pkgs.bat-extras.batman}/bin/batman";
          jrun = "${pkgs.maven}/bin/mvn compile && mvn exec:java";
          jj = "javac *.java && java Main";
          kk = "mvn compile && mvn exec:java";
          "vim." = "nvim .";
        };
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        initExtra = ''ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
        source ${toString ./config/p10k.zsh }
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme'';
      };
    };
  };
}
