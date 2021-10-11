{ config, pkgs, ... }:
{
  programs.kakoune = {
    enable = true;

    plugins = [
      pkgs.kakounePlugins.kak-fzf
      pkgs.kakounePlugins.powerline-kak
    ];

    config = {
      colorScheme = "gruvbox";
      autoReload = "ask";
      
      alignWithTabs = true;
      tabStop = 2;
      indentWidth = 2;

      scrollOff.lines = 8;
      scrollOff.columns = 4;

      numberLines = {
        enable = true;
        relative = false;
        # separator = "|";
      };

      ui = {
        enableMouse = true;
        assistant = "none";
        statusLine = "bottom";
      };
      
      wrapLines = {
        enable = false;
        indent = true;
        marker = "⏎";
      };
      
      # keyMappings = {};
    };

    extraConfig = ''
      powerline-start
    '';
  };
}
