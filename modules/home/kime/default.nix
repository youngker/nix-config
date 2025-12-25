{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.i18n.inputMethod.kime;
in
{
  options.modules.i18n.inputMethod.kime = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    i18n.inputMethod.enable = true;
    i18n.inputMethod.type = "kime";
    xdg.configFile."kime".source = ./kime;
  };
}
