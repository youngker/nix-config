{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.wayland;
in
{
  options.modules.services.wayland = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      config = {
        niri = {
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };
    };
    security.pam.services.swaylock = { };
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    programs.xwayland.enable = true;
    programs.niri.enable = true;
    services.gnome.gcr-ssh-agent.enable = false;
  };
}
