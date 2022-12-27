{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.i18n.inputMethod.kime.enable {
    i18n.inputMethod.kime.config = {
      engine = {
        global_hotkeys = {
          S-Space = {
            behavior = { Toggle = [ "Hangul" "Latin" ]; };
            result = "Consume";
          };
        };
        hangul = { layout = "dubeolsik"; };
      };
    };
  };
}
