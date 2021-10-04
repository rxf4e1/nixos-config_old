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
      enableZshIntegration = true;
    };
  };
}
