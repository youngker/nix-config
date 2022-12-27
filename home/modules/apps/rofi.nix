{ lib, pkgs, config, ... }:

with lib; {
  options.modules.apps.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.rofi.enable {
    home.packages = with pkgs; [ rofi ];
  };
}
