{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.mpd;
in
{
  options.modules.services.mpd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
    };

  };
}
