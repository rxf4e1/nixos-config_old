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
    gimp
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
      changeDirWidgetCommand = "fd --color=auto --type=d";
      changeDirWidgetOptions = [ "--preview 'exa --tree --color=always -L 4 {}'" ];
      defaultCommand = "fd --color=auto";
      fileWidgetCommand = "fd --color=auto --type=f";
      fileWidgetOptions = [ "--preview 'head -n 100 {}'" ];
      enableZshIntegration = true;
    };

    mpv = {
      enable = true;
      # package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override { vapoursynthSupport = true; }) { youtubeSupport = true; }
      # config = {};
    };
    
  };
}
