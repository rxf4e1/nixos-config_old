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

  home.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    GDK_DPI_SCALE = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland-egl";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    SDL_VIDEODRIVER = "wayland";
    WLR_NO_HARDWARE_CURSORS = 1;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
  };

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        config = rec {

          output."*" = {
            bg = "$HOME/Downloads/imgs/qwe_download.jpg fill";
          };

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

          floating.criteria = [
            { title = "Nitrogen"; }
          ];

          startup = [
            # { command = "nitrogen --restore"; }
          ];
        }; # end config #
        
      };
    };
  };
}
