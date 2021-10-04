{ config, pkgs, lib, ... }:

let

  cfg = config.wayland.windowManager.sway.config;

  fontConf = {
    names = [ "TerminessTTF Nerd Font Mono" ];
    style = "Normal";
    size = 10.0;
  };

  wallpaper = "/media/data/10-19-docs/12-images/wallpapers/cyberpunk_2077.jpg";

in {
  home.packages = with pkgs; [
    autotiling
    brightnessctl
    kanshi 
    mako
    wl-clipboard
    bemenu
    xwayland
  ];

  home.sessionVariables = {
    BEMENU_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    # GDK_DPI_SCALE = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland-egl";
    # QT_WAYLAND_FORCE_DPI = "physical";
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
        config = {

          output."*" = {
            bg = "${wallpaper} fill";
          };

          input."type:keyboard" = {
            xkb_layout = "br";
            xkb_variant = "abnt2";
            # xkb_numlock = "enable";
          };
          
          modifier = "Mod4";
          menu = "${pkgs.bemenu}/bin/bemenu-run | ${pkgs.findutils}/bin/xargs swaymsg exec --";

          bars = [ ];

          gaps = {
            inner = 1;
            outer = 1;
          };

          fonts = fontConf;
          terminal = "${pkgs.alacritty}/bin/alacritty";

          window = {
            border = 0;
            titlebar = false;
            hideEdgeBorders = "both";
          };

          floating = {
            titlebar = true;
            border = 1;
          };

          workspaceAutoBackAndForth = true;

          keybindings = {
            # Basics
            "${cfg.modifier}+Return"    = "exec ${cfg.terminal}";
            "${cfg.modifier}+Shift+q"   = "kill";
            "${cfg.modifier}+d"         = "exec ${cfg.menu}";
            "${cfg.modifier}+Control+r" = "reload";
            "${cfg.modifier}+Escape"    = "exec swaynag -t warning -m 'Do you really want to exit sway? ' -b 'Yes, exit sway' 'swaymsg exit'";
            # Focus
            "${cfg.modifier}+${cfg.left}" = "focus left";
            "${cfg.modifier}+${cfg.down}" = "focus down";
            "${cfg.modifier}+${cfg.up}" = "focus up";
            "${cfg.modifier}+${cfg.right}" = "focus right";

            "${cfg.modifier}+Left" = "focus left";
            "${cfg.modifier}+Down" = "focus down";
            "${cfg.modifier}+Up" = "focus up";
            "${cfg.modifier}+Right" = "focus right";
            # Moving
            "${cfg.modifier}+Shift+${cfg.left}" = "move left";
            "${cfg.modifier}+Shift+${cfg.down}" = "move down";
            "${cfg.modifier}+Shift+${cfg.up}" = "move up";
            "${cfg.modifier}+Shift+${cfg.right}" = "move right";

            "${cfg.modifier}+Shift+Left" = "move left";
            "${cfg.modifier}+Shift+Down" = "move down";
            "${cfg.modifier}+Shift+Up" = "move up";
            "${cfg.modifier}+Shift+Right" = "move right";
            # Workspaces
            "${cfg.modifier}+1" = "workspace number 1";
            "${cfg.modifier}+2" = "workspace number 2";
            "${cfg.modifier}+3" = "workspace number 3";
            "${cfg.modifier}+4" = "workspace number 4";
            "${cfg.modifier}+5" = "workspace number 5";
            "${cfg.modifier}+6" = "workspace number 6";
            "${cfg.modifier}+7" = "workspace number 7";
            "${cfg.modifier}+8" = "workspace number 8";
            "${cfg.modifier}+9" = "workspace number 9";
            "${cfg.modifier}+0" = "workspace number 10";

            "${cfg.modifier}+Shift+1" = "move container to workspace number 1";
            "${cfg.modifier}+Shift+2" = "move container to workspace number 2";
            "${cfg.modifier}+Shift+3" = "move container to workspace number 3";
            "${cfg.modifier}+Shift+4" = "move container to workspace number 4";
            "${cfg.modifier}+Shift+5" = "move container to workspace number 5";
            "${cfg.modifier}+Shift+6" = "move container to workspace number 6";
            "${cfg.modifier}+Shift+7" = "move container to workspace number 7";
            "${cfg.modifier}+Shift+8" = "move container to workspace number 8";
            "${cfg.modifier}+Shift+9" = "move container to workspace number 9";
            "${cfg.modifier}+Shift+0" = "move container to workspace number 10";
            # Moving workspaces between outputs
            "${cfg.modifier}+Control+${cfg.left}" = "move workspace to output left";
            "${cfg.modifier}+Control+${cfg.down}" = "move workspace to output down";
            "${cfg.modifier}+Control+${cfg.up}" = "move workspace to output up";
            "${cfg.modifier}+Control+${cfg.right}" = "move workspace to output right";

            "${cfg.modifier}+Control+Left" = "move workspace to output left";
            "${cfg.modifier}+Control+Down" = "move workspace to output down";
            "${cfg.modifier}+Control+Up" = "move workspace to output up";
            "${cfg.modifier}+Control+Right" = "move workspace to output right";
            # Splits
            "${cfg.modifier}+b" = "splith";
            "${cfg.modifier}+v" = "splitv";
            # Multimedia Keys
            "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
            "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
            # Resize mode
            "${cfg.modifier}+r" = "mode resize";
            # Start Programs
            "${cfg.modifier}+e" = ''exec emacsclient -c -a "" "$@"'';
            "${cfg.modifier}+q" = "exec qutebrowser";
          };

          # startup = [ ];
        }; # end config #
        
      };
    };
  };

  systemd.user.targets.sway-session = {
    Unit = {
      Description = "sway compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
}
