{ config, pkgs, ... }:
{
  programs.kakoune = {
    enable = true;
    plugins = [
      { _type = "literalExpression"; text = "[ pkgs.kakounePlugins.kak-fzf ]"; }
      { _type = "literalExpression"; text = "[ pkgs.kakounePlugins.powerline-kak ]"; }
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
        separator = "|";
      };

      ui = {
        enableMouse = true;
        assistant = "cat";
        statusLine = "bottom";
      };

      # keyMappings = {};


    };
  };
}
