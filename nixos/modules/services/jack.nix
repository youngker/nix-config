{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.jack = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.jack.enable {
    services.jack = {
      jackd.enable = true;
      alsa.enable = false;
      loopback.enable = true;
    };
  };
}
