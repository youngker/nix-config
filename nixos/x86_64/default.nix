{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
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

  hardware.nvidia.open = false;
  hardware.nvidia.prime.offload.enable = false;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

  modules = {
    hardware = {
      pulseaudio.enable = false;
    };

    services = {
      docker.enable = true;
      jack.enable = false;
      virtualbox.enable = false;
      wayland.enable = true;
      xserver.enable = false;
    };
  };
}
