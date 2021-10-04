# https://git.sbruder.de/simon/nixos-config/src/branch/master/users/simon/modules/sway/kanshi.nix
{ lib, nixosConfig, ... }:
{
  services.kanshi = {
    enable = true;
    profiles = getMachineConfig (nixosConfig.networking.hostName);
  };
}
