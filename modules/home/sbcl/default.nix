{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.sbcl;
in
{
  options.modules.dev.sbcl = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ sbcl ]; };
}
