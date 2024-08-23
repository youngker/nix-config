{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.hardware.nixosModules.common-hidpi
    ../common
    ./hardware-configuration.nix
  ];

  home-manager.users.${outputs.user.name} = outputs.homeConfigurations.nixos-aarch64;

  modules = {
    hardware = {
      nvidia.enable = false;
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
