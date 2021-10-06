{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bat
    dmenu
    exa
    fd
    killall
    neovim
    poppler
    ripgrep
    zathura
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };

    fzf = {
      enable = true;
      changeDirWidgetCommand = "fd --color always --type d";
      changeDirWidgetOptions = [ "--preview 'exa --tree --color=always -L 4 {}'" ];
      defaultCommand = "fd --color always";
      fileWidgetCommand = "fd --color always --type f";
      fileWidgetOptions = [ "--preview 'head -n 100 {}'" ];
      enableZshIntegration = true;
    };
  };
}
