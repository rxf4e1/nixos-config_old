{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    brave
  ];

  programs.qutebrowser = {
    enable = true;
    settings = {
      fonts = {
        default_size = "7pt";
      };
    };
    searchEngines = {
      nw = "https://nixos.wiki/index.php?search={}";
      no = "https://search.nixos.org/packages?query={}";
      g  = "https://www.google.com/search?hl=en&q={}";
    };
    enableDefaultBindings = true;
  };
}
