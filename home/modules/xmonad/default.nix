{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.xmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.xmonad.enable {
    xsession.enable = true;
    xsession.initExtra = ''
      export LIBGL_DRIVERS_PATH="${pkgs.mesa.drivers}/lib/dri"
      export LD_LIBRARY_PATH="${pkgs.mesa.drivers}/lib/":$LD_LIBRARY_PATH
      export XDG_CURRENT_DESKTOP="xmonad"
    '';
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };

    xresources.properties."Xft.dpi" = 120;
  };
}
