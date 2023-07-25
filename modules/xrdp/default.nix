{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.xrdp;
in {
  options.modules.services.xrdp = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.xrdp.enable = true;
    networking.firewall.allowedTCPPorts = [ 3389 ];
  };
}
