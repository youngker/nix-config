{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.boot.loader;
in {
  options.modules.boot.loader = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
    };
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
