{ config, pkgs, lib, ... }:

let

  fontConf = {
    names = [ "TerminessTTF Nerd Font Mono" ];
    style = "Normal";
    size = 12.0;
  };

in {
  home.packages = with pkgs; [
    autotiling
    kanshi 
    mako
    wl-clipboard
    wofi
    xwayland
  ];

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        config = rec {

          input."*" = {
            xkb_layout = "br";
            xkb_variant = "abnt2";
          };
          
          modifier = "Mod4";

          bars = [ ];

          gaps = {
            inner = 2;
            outer = 2;
          };

          fonts = fontConf;
          terminal = "${pkgs.alacritty}/bin/alacritty";

          window = {
            border = 0;
            titlebar = false;
            hideEdgeBorders = "both";
          };

          workspaceAutoBackAndForth = true;

          startup = [
            # { command = "nitrogen --restore"; notification = false; }
          ];
        }; # end config #
        
      };
    };
  };
}
