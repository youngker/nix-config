{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.font;
in {
  options.modules.desktop.font = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable =
      if builtins.pathExists /etc/NIXOS then false else true;
    home.packages = with pkgs; [
      fira-code
      font-awesome_4
      noto-fonts-cjk
      xorg.fontbhlucidatypewriter75dpi
      xorg.fontbhlucidatypewriter100dpi
    ];
  };
}
