{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.xserver;
in
{
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
      xkb.layout = "us";
      dpi = 179;
      upscaleDefaultCursor = true;
    };
    services.xrdp.enable = true;
    services.displayManager.gdm.enable = true;
    networking.firewall.allowedTCPPorts = [ 3389 ];
  };
}
