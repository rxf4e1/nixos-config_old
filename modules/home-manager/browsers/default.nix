{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    brave
  ];

  programs.qutebrowser = {
    enable = true;
    package = pkgs.qutebrowser;
    enableDefaultBindings = true;
    extraConfig = ''
      # Extra lines added to config.py file.
    '';
  };
}
