{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.wayland;
in {
  options.modules.services.wayland = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.inputs.hyprland.hyprland ];
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      # NIXOS_OZONE_WL = "1";
    };
  };
}
