{ pkgs, lib, config, ... }:
let var = import ../../../config.nix;
in with lib; {
  options.modules.services.timesyncd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.timesyncd.enable {
    time.timeZone = var.timezone;
    services.timesyncd.enable = true;
  };
}
