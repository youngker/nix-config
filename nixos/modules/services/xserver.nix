{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.xserver = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.xserver.enable {
    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = true;
      displayManager.gdm.enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];
    };
  };
}
