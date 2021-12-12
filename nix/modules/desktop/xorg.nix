{ pkgs, lib, options, config, ... }:

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
      fira-code
      font-awesome_4
      noto-fonts-cjk
      xorg.xev
      xorg.xfd
      xorg.fontmiscmisc
      xdotool
      xorg.xmessage
    ];
  };
}
