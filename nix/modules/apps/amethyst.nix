{ config, pkgs, options, lib, ... }:

with lib;
{
  options.modules.apps.amethyst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.amethyst.enable {
    home.packages = with pkgs; [ amethyst ];
  };
}
