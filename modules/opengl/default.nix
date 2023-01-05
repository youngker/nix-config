{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.hardware.opengl;
in {
  options.modules.hardware.opengl = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl = {
      driSupport32Bit = true;
    };
  };
}
