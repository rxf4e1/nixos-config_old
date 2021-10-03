{ config, pkgs, lib, ... }:

{
  home.packages = [
    autorandr
    xclip
    xdotool
    xsel
  ];
  
  xdg = {
    enable = true;
    mimeApps = {
      associations.added = {
        "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
      };
    };
  };

  terminator = {
    enable = true;
     config = {
      global_config = {
         borderless = true;
         always_on_top = true;
      };
       profiles = {
         default = {
            visible_bell = true;
            icon_bell = false;
            foreground_color = "#ebdbb2";
            background_color = "#282828";
            cursor_color = "#aaaaaa";
            show_titlebar = true;
            scrollbar_position = "hidden";
            scrollback_infinite = true;
            use_system_font = false;
            font = "TerminessTTF Nerd Font Mono Medium 10";
            palette = "#282828:#cc241d:#98971a:#d79921:#458588:#b16286:#689d6a:#a89984:#928374:#fb4934:#b8bb26:#fabd2f:#83a598:#d3869b:#8ec07c:#ebdbb2";
          };
        };
      };
    };

  xsession = {
    enable = true;
    windowManager.command = ''
      ${pkgs.nitrogen}/bin/nitrogen --restore
    '';
  };
  
  home.file.".xinitrc" = {
    text = ''
      # Disable access control for the current user.
      xhost +SI:localuser:$USER

      # Merge .Xresources
      [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

      # Export Variables
      export _JAVA_AWT_WM_NONREPARENTING=1

      # Scrolling gtk3 apps won't work, unless GDK_CORE_DEVICE_EVENTS is defined
      export GDK_CORE_DEVICE_EVENTS=1

      # Don't turn it off
      xset -dpms
      xset s off

      # Disable touchpad
      xinput disable 15
			
      # Change keyboard CAPS_LOCK with CTRL
      setxkbmap -option ctrl:nocaps
			
      # Set/Fix Cursor	
      xsetroot -cursor_name left_ptr

      # Start WM
      # exec $HOME/.local/bin/stumpwm
      # exec dbus-launch --exit-with-session emacs -mm --debug-init
      
      # emacs --daemon # --eval "(require 'exwm)" -f exwm-enable
      # exec dbus-launch --exit-with-session emacsclient -c
    '';
  };
}
