{ lib, pkgs, config, ... }:

with lib;
{
  config = mkIf config.modules.desktop.xmonad.enable {
    xsession.enable = true;
    xsession.windowManager.xmonad = {
      config = ./xmonad.hs;
    };

    xresources.properties."Xft.dpi" = 120;
  };
}
