{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.i18n.inputMethod.fcitx5;
in
{
  options.modules.i18n.inputMethod.fcitx5 = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-hangul
      ];
    };
  };
}
