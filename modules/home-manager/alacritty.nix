{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 10;
        normal.family = "TerminessTTF Nerd Font Mono";
        bold.family = "TerminessTTF Nerd Font Mono";
        italic.family = "TerminessTTF Nerd Font Mono";
      };
      cursor.style = {
        shape = "Block";
        blinking = "On";
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "none";
      };
      draw_bold_text_with_bright_colors = true;
      background_opacity = 1.0;
      mouse.hide_when_typing = true;
    }; # --- end settings
  };
}
