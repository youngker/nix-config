{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.emacs;
in
{
  options.modules.services.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = true;
    };
  };
}
