{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.apps.bingwallpaper;
in
{
  options.modules.apps.bingwallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ bingwallpaper ]; };
}
