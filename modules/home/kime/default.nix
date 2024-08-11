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
    i18n.inputMethod.enabled = "kime";
    xdg.configFile."kime".source = ./kime;
  };
}
