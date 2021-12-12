{ pkgs, lib, config, ... }:

with lib; {
  options.modules.hardware.nvidia = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.hardware.nvidia.enable {
    hardware.nvidia = {
      modesetting.enable = true;
    };
  };
}
