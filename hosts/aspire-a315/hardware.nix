{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "msr" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/53d3dffe-14c6-41ec-aa2f-c81070f53447";
      fsType = "btrfs";
      options = [ "subvol=root" "noatime" "autodefrag" "space_cache" "compress=zstd" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/53d3dffe-14c6-41ec-aa2f-c81070f53447";
      fsType = "btrfs";
      options = [ "subvol=home" "noatime" "autodefrag" "space_cache" "compress=zstd" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/53d3dffe-14c6-41ec-aa2f-c81070f53447";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "autodefrag" "space_cache" "compress=zstd" ];
    };

  fileSystems."/media/data" =
    { device = "/dev/disk/by-uuid/53d3dffe-14c6-41ec-aa2f-c81070f53447";
      fsType = "btrfs";
      options = [ "subvol=data" "noatime" "autodefrag" "space_cache" "compress=zstd" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/53d3dffe-14c6-41ec-aa2f-c81070f53447";
      fsType = "btrfs";
      options = [ "subvol=log" "noatime" "autodefrag" "space_cache" "compress=zstd" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/572E-05A5";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/c2fa4c6c-1cdf-4ec0-8f80-fe086b8e0695"; }
    ];

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
  };
  
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
