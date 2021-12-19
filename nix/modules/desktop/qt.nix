{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.qt = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.qt.enable {
    home.packages = with pkgs; [ qt5ct ];
  };
}
