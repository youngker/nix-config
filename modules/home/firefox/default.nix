{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.darwin.firefox;
in
{
  options.modules.darwin.firefox = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ firefox-darwin ]; };
}
