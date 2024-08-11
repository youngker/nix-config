{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.dunst;
in
{
  options.modules.services.dunst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.dunst.enable = true;
    home.packages = with pkgs; [ libnotify ];
  };
}
