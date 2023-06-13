{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.hardware.video;
in {
  options.modules.hardware.video = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
  };
}
