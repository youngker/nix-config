{ pkgs, options, config, lib, ... }:

with lib; {
  options.modules.services.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.rofi.enable {
    home.packages = with pkgs; [ rofi ];
  };
}
