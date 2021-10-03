{ lib, config, pkgs, ... }:

{
  # Add the offload script to the $PATH.
  environment.systemPackages = with pkgs; [
    vulkan-headers
    vulkan-loader
  ];

  # Configure XDG compliance.
  environment.variables = {
    __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/amd";
  };

  # Enable the AMDGPU drivers.
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Update AMD Microcode
  hardware.cpu.amd.updateMicrocode = true;
  
  # Add OpenGL support.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs; [
      libva
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
