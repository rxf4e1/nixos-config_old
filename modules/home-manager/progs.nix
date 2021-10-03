{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bat
    brave
    brightnessctl
    dmenu
    exa
    fd
    killall
    lazygit
    nitrogen
    poppler
    ripgrep
    scrot
    qutebrowser
    zathura
    neovim
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
