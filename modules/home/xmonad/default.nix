{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.desktop.xmonad;
in
{
  options.modules.desktop.xmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    xsession.enable = true;
    xsession.initExtra = ''
      export LIBGL_DRIVERS_PATH="${pkgs.mesa}/lib/dri"
      export LD_LIBRARY_PATH="${pkgs.mesa}/lib/":$LD_LIBRARY_PATH
      export XDG_CURRENT_DESKTOP="xmonad"
    '';
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
