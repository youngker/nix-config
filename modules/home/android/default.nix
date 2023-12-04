{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.apps.android;
in {
  options.modules.apps.android = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      android-studio
      android-tools
    ];
  };
}
