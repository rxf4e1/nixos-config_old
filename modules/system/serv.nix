{ config, pkgs, ... }:

{
  services = {

    dbus  = {
      enable = true;
    };
    journald = {
      extraConfig = "SystemMaxUse=256M";
    };
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
    printing = {
      enable = false;
    };
    xserver = {
      enable = true;
      dpi = 72;
      layout = "br";
      xkbVariant = "abnt2";
      libinput = {
        enable = true;
        touchpad = {
          tapping = false;
        };
      };
      displayManager = {
        startx.enable = true;
      };
    };
  };
}