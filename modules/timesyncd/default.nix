{ config, lib, pkgs, user, ... }:

with lib;
let cfg = config.modules.services.timesyncd;
in {
  options.modules.services.timesyncd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = user.timezone;
    services.timesyncd.enable = true;
  };
}
