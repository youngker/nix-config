{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.wayland;
in {
  options.modules.services.wayland = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

  };
}
