{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.jack;
in {
  options.modules.services.jack = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.jack = {
      jackd.enable = true;
      alsa.enable = false;
      loopback.enable = true;
    };
  };
}
