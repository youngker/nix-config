{ lib, pkgs, config, ... }:

with lib;
{
  config = mkIf config.modules.desktop.xmonad.enable {
    xsession.enable = true;
    xsession.initExtra = ''
        export LIBGL_DRIVERS_PATH="${pkgs.mesa.drivers}/lib/dri"
        export LD_LIBRARY_PATH="${pkgs.mesa.drivers}/lib/":$LD_LIBRARY_PATH
    '';
    xsession.windowManager.xmonad = {
      config = ./xmonad.hs;
    };

    xresources.properties."Xft.dpi" = 120;
  };
}
