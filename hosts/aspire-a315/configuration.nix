{config, pkgs, inputs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    cleanTmpDir = true;
    initrd = {
      checkJournalingFS = false;
    };
    kernelParams = [
      "nohibernate"
      "ipv6.disable=0"
      "acpi_brightness=vendor"
      "msr.allow_writes=on"
    ];
    kernel.sysctl = {
      "vm.swappiness"=10;
      "vm.vfs_cache_pressure"=50;
      "vm.dirty_background_ratio"=1;
    };
  };

  networking = {
    hostName = "aspire-a315";
    nameservers = ["1.1.1.1"];
    networkmanager = {
      enable = true;
      dns = "none";
      insertNameservers = ["127.0.0.1"];
    };
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    firewall.enable = false;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
    openrazer = {
      enable = true;
    };
  };

  documentation = {
    man.enable = true;
    info.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  time = {
    timeZone = "America/Sao_Paulo";
  };
}
