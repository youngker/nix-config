{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.guile;
in
{
  options.modules.dev.guile = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      guile_3_0
      guile-lib
      guile-reader
    ];
  };
}
