{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.hardware.nvidia;
in {
  options.modules.hardware.nvidia = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    hardware.nvidia = {
      modesetting.enable = true;
    };
  };
}
