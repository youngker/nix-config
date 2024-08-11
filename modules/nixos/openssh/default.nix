{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.openssh;
in
{
  options.modules.services.openssh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.openssh.enable = true;
    services.openssh.startWhenNeeded = true;
  };
}
