{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.rofi.enable {
    home.packages = with pkgs; [ rofi ];
  };
}
