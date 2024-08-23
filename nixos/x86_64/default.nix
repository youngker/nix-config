{
  inputs,
  outputs,
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

  home-manager.users.${outputs.user.name} = outputs.homeConfigurations.nixos-x86_64;

  hardware.nvidia.prime.offload.enable = false;
  hardware.nvidia.modesetting.enable = true;

  modules = {
    hardware = {
      nvidia.enable = false;
      pulseaudio.enable = false;
    };

    services = {
      docker.enable = true;
      jack.enable = false;
      virtualbox.enable = true;
      wayland.enable = false;
      xserver.enable = true;
    };
  };
}
