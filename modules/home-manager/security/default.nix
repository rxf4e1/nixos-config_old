{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    keepassxc
    pass
  ];
  
  home.file.".authinfo".source = ../../../config/authinfo;
}
