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
        enable = true;    # false;
        touchpad = {
          tapping = true; # false;
        };
      };
      displayManager = {
        startx.enable = true;
      };
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
      # dataDir = "/var/lib/postgresql/$psqlSchema";
    };
  };
}
