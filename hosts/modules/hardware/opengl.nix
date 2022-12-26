{ pkgs, lib, config, ... }:

with lib; {
  options.modules.hardware.opengl = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.hardware.opengl.enable {
    hardware.opengl = {
      driSupport32Bit = true;
    };
  };
}
