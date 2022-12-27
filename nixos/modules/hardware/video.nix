{ pkgs, lib, config, ... }:

with lib; {
  options.modules.hardware.video = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.hardware.video.enable {
    hardware.video = {
      hidpi.enable = true;
    };
  };
}
