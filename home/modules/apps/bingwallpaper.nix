{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.apps.bingwallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.bingwallpaper.enable {
    home.packages = with pkgs; [ my.bingwallpaper ];
  };
}
