{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.timesyncd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.timesyncd.enable {
    time.timeZone = "Asia/Seoul";
    services.timesyncd.enable = true;
  };
}
