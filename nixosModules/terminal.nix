{
  programs = {
    git.enable = true;
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
    tmux = {
      enable = true;
      shortcut = "b";
    };
    nano.enable = false;
  };
}
