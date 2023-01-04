{ pkgs, lib, config, user, ... }:

with lib; {
  options.modules.services.timesyncd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.timesyncd.enable {
    time.timeZone = user.timezone;
    services.timesyncd.enable = true;
  };
}
