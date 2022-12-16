{ lib, pkgs, config, ... }:

with lib; {
  options.modules.i18n.inputMethod.kime = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.i18n.inputMethod.kime.enable {
    i18n.inputMethod.enabled = "kime";
  };
}
