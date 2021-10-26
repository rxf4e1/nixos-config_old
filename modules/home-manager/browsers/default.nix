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
      g = "https://www.google.com/search?hl=en&q={}";
      gs = "https://scholar.google.com/scholar?q={}";
      # gh = "https://github.com/search?q={}";
      # isbn = "https://isbnsearch.org/search?s={}";
      # lbry = "https://lbry.tv/$/search?q={}";
      # ncbi = "https://www.ncbi.nlm.nih.gov/nuccore/?term={}";
      od = "https://odysee.com/$/search?q={}";
      # pub = "https://pubmed.ncbi.nlm.nih.gov/?term={}";
      # ud = "https://www.udemy.com/courses/search/?src={}";
      yt = "https://www.youtube.com/results?search_query={}";      
    };
    enableDefaultBindings = true;
  };
}
