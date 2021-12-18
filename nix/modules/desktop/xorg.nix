{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.xorg = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.xorg.enable {
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
