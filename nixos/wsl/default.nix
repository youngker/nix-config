{
  inputs,
  outputs,
  pkgs,
  lib,
  isWsl ? false,
  ...
}:

{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    ../common
    ./hardware-configuration.nix
  ];
  home-manager.extraSpecialArgs = { inherit inputs outputs; };
  home-manager.users.${outputs.user.name} = outputs.lib.homeConfigurations.nixos-x86_64;

  hardware.nvidia.open = false;
  hardware.nvidia.prime.offload.enable = false;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaPersistenced = true;

  wsl = {
    enable = true;
    defaultUser = outputs.user.name;
    startMenuLaunchers = true;
  };

  modules = {
    hardware = {
      pulseaudio.enable = false;
    };
    services = {
      docker.enable = true;
      jack.enable = false;
      virtualbox.enable = false;
      wayland.enable = false;
      xserver.enable = true;
    };
  };
}
