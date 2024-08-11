{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.apps.xterm-24bit;
in
{
  options.modules.apps.xterm-24bit = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xterm-24bit ]; };
}
