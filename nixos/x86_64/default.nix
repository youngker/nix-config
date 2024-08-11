{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    ../common
    ./hardware-configuration.nix
  ];

  modules = {
    hardware = {
      nvidia.enable = true;
      pulseaudio.enable = false;
    };

    services = {
      docker.enable = true;
      jack.enable = false;
      virtualbox.enable = true;
      wayland.enable = true;
      xserver.enable = false;
    };
  };
}
