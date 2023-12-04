{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.xserver;
in {
  options.modules.services.xserver = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = true;
      displayManager.gdm.enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];
    };
  };
}
