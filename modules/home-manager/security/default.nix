{ config, pkgs, ... }:

{
  home.packages = [
    keepassxc
    pass
  ];
  
  home.file.".authinfo".source = ../../config/authinfo;
}
