{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      background_opacity = 0.96;
      font = {
        size = 10.5;
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
          x = 0;
          y = 0;
        };
        decorations = "none";
      };
      draw_bold_text_with_bright_colors = true;
      mouse.hide_when_typing = true;
    }; # --- end settings
  };
}
