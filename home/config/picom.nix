{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.services.picom.enable {
    services.picom = optionalAttrs pkgs.stdenv.isLinux {
      fade = true;
      fadeDelta = 5;
      shadow = true;
      backend = "glx";
    };
  };
}
