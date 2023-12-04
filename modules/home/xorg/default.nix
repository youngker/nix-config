{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.xorg;
in {
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
      xorg.xev
      xorg.xfd
      xorg.fontmiscmisc
      xdotool
      xorg.xmessage
    ];
  };
}
