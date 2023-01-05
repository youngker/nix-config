{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.apps.pandoc;
in {
  options.modules.apps.pandoc = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pandoc ];
  };
}
