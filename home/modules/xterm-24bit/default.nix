{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.apps.xterm-24bit = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.xterm-24bit.enable {
    home.packages = with pkgs; [ xterm-24bit ];
  };
}
