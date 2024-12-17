{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.desktop.qt;
in
{
  options.modules.desktop.qt = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ libsForQt5.qt5ct ]; };
}
