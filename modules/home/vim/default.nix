{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.apps.vim;
in
{
  options.modules.apps.vim = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ vim ]; };
}
