{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.desktop.xorg;
in
{
  options.modules.desktop.xorg = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      arandr
      brightnessctl
      xev
      xfd
      font-misc-misc
      xdotool
      xmessage
    ];
    xresources.properties."Xft.dpi" = 179;
    xresources.properties."Xcursor.size" = 128;
  };
}
